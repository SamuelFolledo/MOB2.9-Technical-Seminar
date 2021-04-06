/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import Combine

// 1 Make WeeklyWeatherViewModel conform to ObservableObject and Identifiable. Conforming to these means that the WeeklyWeatherViewModel‘s properties can be used as bindings
class WeeklyWeatherViewModel: ObservableObject, Identifiable {
  // 2 The property delegate @Published modifier makes it possible to observe the city property. You’ll see in a moment how to leverage this
  @Published var city: String = ""

  // 3 You’ll keep the View’s data source in the ViewModel. This is in contrast to what you might be used to doing in MVC. Because the property is marked @Published, the compiler automatically synthesizes a publisher for it. SwiftUI subscribes to that publisher and redraws the screen when you change the property.
  @Published var dataSource: [DailyWeatherRowViewModel] = []

  private let weatherFetcher: WeatherFetchable

  // 4 Think of disposables as a collection of references to requests. Without keeping these references, the network requests you’ll make won’t be kept alive, preventing you from getting responses from the server.
  private var disposables = Set<AnyCancellable>()

//  init(weatherFetcher: WeatherFetchable) {
//    self.weatherFetcher = weatherFetcher
//  }
  // 1 Add a scheduler parameter, so you can specify which queue the HTTP request will use.
  init(
    weatherFetcher: WeatherFetchable,
    scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
  ) {
    self.weatherFetcher = weatherFetcher
    // 2 The city property uses the @Published property delegate so it acts like any other Publisher. This means it can be observed and can also make use of any other method that is available to Publisher.
    $city
      // 3 As soon as you create the observation, $city emits its first value. Since the first value is an empty string, you need to skip it to avoid an unintended network call.
      .dropFirst(1)
      // 4 Use debounce(for:scheduler:) to provide a better user experience. Without it the fetchWeather would make a new HTTP request for every letter typed. debounce works by waiting half a second (0.5) until the user stops typing and finally sending a value. You can find a great visualization of this behavior at RxMarbles. You also pass scheduler as an argument, which means that any value emitted will be on that specific queue. Rule of thumb: You should process values on a background queue and deliver them on the main queue.
      .debounce(for: .seconds(0.5), scheduler: scheduler)
      // 5 You observe these events via sink(receiveValue:) and handle them with fetchWeather(forCity:) that you previously implemented.
      .sink(receiveValue: fetchWeather(forCity:))
      // 6 Finally, you store the cancelable as you did before.
      .store(in: &disposables)
  }
  
  //MARK: Methods
  func fetchWeather(forCity city: String) {
    // 1 Start by making a new request to fetch the information from the OpenWeatherMap API. Pass the city name as the argument.
    weatherFetcher.weeklyWeatherForecast(forCity: city)
      .map { response in
        // 2 Map the response (WeeklyForecastResponse object) to an array of DailyWeatherRowViewModel objects. This entity represents a single row in the list. You can check the implementation located in DailyWeatherRowViewModel.swift. With MVVM, it’s paramount for the ViewModel layer to expose to the View exactly the data it will need. It doesn’t make sense to expose directly to the View a WeeklyForecastResponse, since this forces the View layer to format the model in order to consume it. It’s a good idea to make the View as dumb as possible and concerned only with rendering.
        response.list.map(DailyWeatherRowViewModel.init)
      }
      // 3 The OpenWeatherMap API returns multiple temperatures for the same day depending on the time of the day, so remove the duplicates. You can check Array+Filtering.swift to see how that’s done.
      .map(Array.removeDuplicates)
      // 4 Although fetching data from the server, or parsing a blob of JSON, happens on a background queue, updating the UI must happen on the main queue. With receive(on:), you ensure the update you do in steps 5, 6 and 7 occurs in the right place.
      .receive(on: DispatchQueue.main)
      // 5 Start the publisher via sink(receiveCompletion:receiveValue:). This is where you update dataSource accordingly. It’s important to notice that handling a completion — either a successful or failed one — happens separately from handling values.
      .sink(
        receiveCompletion: { [weak self] value in
          guard let self = self else { return }
          switch value {
          case .failure:
            // 6 In the event of a failure, set dataSource as an empty array.
            self.dataSource = []
          case .finished:
            break
          }
        },
        receiveValue: { [weak self] forecast in
          guard let self = self else { return }
          // 7 Update dataSource when a new forecast arrives.
          self.dataSource = forecast
      })
      // 8 Finally, add the cancellable reference to the disposables set. As previously mentioned, without keeping this reference alive, the network publisher will terminate immediately.
      .store(in: &disposables)
  }
}

