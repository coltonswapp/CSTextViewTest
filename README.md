### CSTextView (experimental)

#### As it stands
![myGif](https://github.com/coltonswapp/CSTextViewTest/blob/main/CSTextViewTest/CSTextView.gif)

#### Goal
- Take criticisms and find better ways to build interactions like this
- Discover if UIViewControllerAnimatedTransitioning is a better approach for something like this

#### Notes
- You'll notice that the viewController is presented using a `.crossDissolve` and `.overfullscreen` for `.modalPresentationStyle` and `.modalTransitionStyle` respectively.
- This results in the view dissolving onto the stack, which is the kind of thing that I want for the `blurView` (darkened view behind textEntry container view),
but I would rather that the containerView have full opacity as it is presented from the bottom of the screen.
- In the same vain, rather than the containerView disssolving off the stack as it is dismissed, I want it to slide (at full opacity) off the bottom of the screen.
- Overall, struggling in general to have the blurView remain dissolving in and out, while having the container view slide up and down at full opacity. 
