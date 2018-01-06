import Foundation

class Motivation {

    let quotes = [
        "Eating a healthy diet as well as exercising can lead to a better physique",
        "Eating right can help you avoid excess weight gain and maintain a healthy weight",
        "A number of studies confirm that just by eating slower, you’ll consume fewer calories",
        "It takes about 20 minutes for our brains to understand that we’re full",
        "Looking to lose weight? Eating slowly should be a part of your lifestyle",
        "Enjoy your meal mindfully",
        "Eating slower and chewing your food better leads to better digestion",
        "Eat your meal as a mindfulness exercise",
        "Take small bites, chew slower, enjoy your meal longer",
        "Many studies demonstrated the benefits of eating slower and chewing longer",
        "Slow down your rhythm and you'll eat less",
        "Drink more water during meals to feel less hungry at the end",
        "Increasing the number of chews before swallowing reduces food consumption",
        "Prolonged chewing helps prevent diabetes",
        "Longer chewing results in fewer calories being consumed",
        "Eating quickly can triple the risk of becoming overweight",
        "When you eat quickly your body doesn't have the time to process",
        "Studies show that you should do at least 40 chews per bite",
        "Leave the fork on the table. Chew slowly. Stop talking",
        "Slow down your eating, enjoy improved well-being and health",
        "Take the time to savor your food and chew it properly",
        "Learning to eat slower is a simple yet powerful concept to improve your overall health",
        "Give your body the time to recognize you’re full",
        "Eating slowly helps your digestion",
        "Eating slowly helps you eating less",
        "Eating slowly can decrease hunger and lead to higher levels of satiety",
        "Fast eaters gain more weight over time",
        "Try achieving a minimum number of chews per bite",
        "Reserve this time to just eat"
    ]

    var randomQuote: String {
        let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        return quotes[randomIndex]
    }
}
