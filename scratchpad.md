- Process Meal To Add .Moving Event a Grade (Bad, Medium, Good)

in order to draw the graph of the meal it's needed to add a grade to each event, so it's draw with different intensity and color

GOOD > x seconds > BAD > y seconds > WORST

Sampling 50 Hz (0,020s)
Buffer of 25 samples
500 ms between sample

2) Extract MovingFilter from MealAnalyser to group moving events
3) Grade the movings with new object MovingGrader
4) Make MealAnalyser use MovingFilter & MovingGrader
