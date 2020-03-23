#### Notes

Example playground `Tempo.playground` fails to compile with the following errors:

>error: Tempo.playground:104:7: error: type 'CounterComponent' does not conform to protocol 'Component'
class CounterComponent: Component {
      ^
error: Tempo.playground:104:7: error: type 'CounterComponent' does not conform to protocol 'ComponentType'
class CounterComponent: Component {

#### Known Issues 

* ListView: Issue where, if image calls time out, or on subsequent app loads, original images are overwritten with either the placeholder image or the last loaded image
* ListView: Issue where the `titleLabel` will sometimes oversize its height, resulting in a large top margin.

#### Future Enhancements

* Add product to local cart
* Add product to local list 
* Create a new product list 
* View Cart 
* Checkout 
* Image loading spinner/activity indicator

#### Implementation Details

In general I tried to follow the patterns laid out by `Tempo` and `Harmony`. There were some cases where I fell back to a more generalized MVVM-C approach due to my level of familiarity.

<hr />

In the `ProductListComponent` I pass a `UIImageView` through to the details via eventing to be used in `DetailViewState`

```swift
func selectView(_ view: ProductListView, item: ListItemViewState) {
    dispatcher?.triggerEvent(ListItemPressed(listItem: item, image: view.productImage.image))
}
```
in a production app I'd expect that there'd be a seperate details call that provides a list of images and product information. Alternatively, the image could be pulled from the image cache, instead of being taken from the cell's `UIImageView` and passed along.

<hr />

My dynamic cell height calculations look something like: 
```swift
func heightForLayout(_ layout: HarmonyLayout, item: TempoViewStateItem, width: CGFloat) -> CGFloat {
    guard let state = item as? ListItemViewState else { return 100.0 }
    
    self.configureView(sizingView, item: state)
    
    self.sizingView.bounds = CGRect(x: 0.0, y: 0.0, width: width, height: sizingView.bounds.height)
    self.sizingView.layoutIfNeeded()
    
    return sizingView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
}
```
this is the approach that I'd normally take without `Harmony`, I imagine there a pattern that is generally used instead of this based on the api.

<hr />

The `Product Detail` page is using a harmony collection view (to demonstrate use of the pattern), which means that portions of the page may appear off of the screen depending on device and the length of the description. In general, I like to have actions be visible on screen whenever possible, perhaps with a scrolling content area or scaled image if needed. 

My usual approach for a screen like this would be to make a `UIViewController` in a `.xib` and design the entire screen there, due to its simplicity. 
