 ![Cover](https://user-images.githubusercontent.com/19142381/85344674-b3b92100-b4c6-11ea-9886-481c77616f94.png)

# HubStarts project

## Features description

- **Displays list of most popular GitHub `Swift` repositories.** Fetches info from [GitHub API](https://developer.github.com/v3/).
- **Infinite scroll.** More content is shown as the user scrolls down.
- **Pull to refresh.** Scroll down on the beginning of the list to refresh its content.
- **Go to repository web page.** The web page is displayed in a  `SFSafariViewController`.
- **Back to top.** After the first page is loaded, a button to go back to top of list is available.
- **Alert on network error.** If any error occurs during the request, an alert message is displayed.
- **Responsive layout**. The layout is adaptive to small and large devices, in landscape or portrait mode.
- **Friendly loading indicator.** A skeleton view is shown when loading cells.
- **Supports dark mode.**
- **Texts in english and portuguese.**

## Technical description

These are the patterns and frameworks used in this project.
- **MVVM-C Architecture**. It separates the responsibilities and keep the code easier to unit test.
- **Views were created programmatically**.
- **Binding VM-View with delegate pattern.**
- **Generic class to network requests.** This same class could be used to get data from other APIs over the app, if necessary.
- **Unit tests of View-Models and Models with `Quick&Nimble`.**
- **UI tests with `iOSSnapshotTestCase`.**
- **Use SwiftLint to keep code format.**

## Screenshots

| List of repositories | Infinite scroll |
|---|---|
| ![loading cells](https://user-images.githubusercontent.com/19142381/85345289-85d4dc00-b4c8-11ea-91be-b07df7aef110.gif) | ![loading_more_cells](https://user-images.githubusercontent.com/19142381/85344633-997f4300-b4c6-11ea-98d1-205e2f06e31e.gif) |

| Pull to refresh | Go to repo web page |
|---|---|
![pull_to_refresh](https://user-images.githubusercontent.com/19142381/85344623-9421f880-b4c6-11ea-8150-269afac497e7.gif) | ![sf_safari_controller](https://user-images.githubusercontent.com/19142381/85344620-91270800-b4c6-11ea-9348-f67a5914fbd0.gif) |

| Back to top | Network error alert |
|---|---|
![back_to_top](https://user-images.githubusercontent.com/19142381/85344626-96845280-b4c6-11ea-822c-1fe6a6306def.gif)  | ![errror_networks](https://user-images.githubusercontent.com/19142381/85344616-8e2c1780-b4c6-11ea-988a-d864b98bb938.gif)  | 

| Dark mode |  Smaller screen  |
|---|---|
![dark_mode](https://user-images.githubusercontent.com/19142381/85344608-8b312700-b4c6-11ea-82c4-d7c56ece62ce.png)  | ![iphone_se](https://user-images.githubusercontent.com/19142381/85344612-8d938100-b4c6-11ea-8627-69f7c03471a7.png) | 

| Larger screen  |
|---|
![large_screen](https://user-images.githubusercontent.com/19142381/85344613-8d938100-b4c6-11ea-8436-d1ed12ff11b5.png)

## How to use

### Run project
To execute the project you have to:

1. Clone [the repo](https://github.com/deboramour4/hub-stars) or download the ZIP file on a Mac
1. If you choose to download the ZIP file, unzip it
1. Open the unziped folder
1. Go to `HubStars` folder
1. Open  `HubStars.xcworkspace` with Xcode 11
1. Open terminal and run `pod install` (you must have CocoaPods installed)
1. Pick a simulator (choose an iPhone or iPad with iOS 13+)
1. Run the project (CMD+R)

### Run tests
To run the tests you have to:

1. Repeat the steps of **Run project** section
1. Run tests (CMD+U)

## License
```
MIT License

Copyright (c) 2020 Débora Moura

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
