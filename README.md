# RatingView

<p>
<img src="https://img.shields.io/badge/iOS-15.0-blue">
<img src="https://img.shields.io/badge/Swift-5.9-violet">
</p>

<p>
  	<img src="https://github.com/hishd/RatingView/blob/main/demo.gif?raw=true?raw=true">
</p>

### Overview

A lightweight SwiftUI rating view component which displays a slider like rating with some animation expression.

## Installation

To add **RatingView** to your project:
Add the repository URL to your project’s package dependencies.

## Usage

```swift
struct  ContentView: View {
	@State var isPresented: Bool = false
	@State var rating: Double = 0
	@State var feedback: String = ""

	var body: some View {

		RatingView(titleText: "How is our app experience?") { (rating: Double, feedback: String) in
			self.rating = rating
			isPresented.toggle()
		}
		.alert("Thank you", isPresented: $isPresented) {
				Button("OK") {
				isPresented = false
			}
		} message: {
			Text("Thank you for providing us with \(String(format: "%.1f", rating * 5)) out of 5.")
		}
	}
}
```

### Title Text

To change the title, pass your custom string literal to the **RatingView** initializer.

```swift
RatingView(titleText: "Your custom title") { _,_ in
	self.rating = rating
	isPresented.toggle()
}
```

### Rating Value and Feedback Text

The trailing closure of **RatingView** contains two parameters. The first parameter is the **rating** which is a **Double** and the second parameter is the **feedback** which is a **String**.

```swift
RatingView(titleText: "Title") { (rating: Double, feedback: String) in
	//Your business logic goes here
	//rating = actual rating between 0 - 1.
	//feedback = feedback text string
	
	//Round the double value and multiply with your maximum rating amount.
	//ex: if the user selected 0.75 & your maximum rating is 5, then rating * 5 = 3.75.
	
}
```

### Demo Project

Please review the demo project under the **[RatingViewDemo](https://github.com/hishd/RatingView/tree/main/RatingViewDemo)** directory for a concrete example.


