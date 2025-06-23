👕 Clothesline – SwiftUI Clothing Carousel

Clothesline is a playful SwiftUI app that lets users swipe through a horizontally scrollable rack of virtual clothing items. Each item includes a title, image, and author, and can be expanded for more details or edited/deleted. New clothing items can also be added through a modal form.

This is the stable version using a standard TabView carousel — no curved scrolling logic here. Just a clean, functional, and animated SwiftUI UI.

⸻

✨ Features
	•	Swipe through clothes using a TabView-based carousel
	•	Tap a card to expand it and show details
	•	Edit or delete each clothing item
	•	Add new items using a modal sheet
	•	Animated transitions and a curved line behind the carousel for visual style

⸻

🧠 Techniques Used
	•	State-driven UI with @State for local view logic
	•	TabView Carousel with .page style and index tracking
	•	Expansion Logic to toggle between summary and detail views
	•	Modal Sheet Presentation using .sheet
	•	Callback Closures for parent-child communication (onAdd, onEdit, onDelete)
	•	GeometryReader to scale content responsively
	•	Custom Shape Drawing with ClotheslineCurve as the decorative arc
	•	Soft shadows + minimal UI for a subtle neumorphic feel

⸻

📦 Project Structure
	•	ClotheslineView.swift – main UI view with swipeable clothing cards
	•	ClothingItemView.swift – the visual card for each item (expandable)
	•	NewItemView.swift – modal form for adding new clothing items
	•	ClotheslineCurve.swift – custom shape behind the carousel
	•	ClothingItem.swift – model struct (title, description, imageName, author)

⸻

🚀 How to Run
	1.	Clone the repo and open in Xcode.
	2.	Make sure you have a few clothing asset images added (e.g. openline-tshirt-yellow).
	3.	Run on a simulator or real device.
	4.	Add items with the plus button and swipe away!

⸻

🧪 Future Ideas
	•	Add drag-to-reorder support
	•	Save items persistently using local storage (e.g. UserDefaults or Core Data)
	•	Add comments or tags per item
	•	Integrate ARKit to try clothes on (just saying…)

⸻

📜 License

MIT — feel free to remix, refactor, and reuse.
