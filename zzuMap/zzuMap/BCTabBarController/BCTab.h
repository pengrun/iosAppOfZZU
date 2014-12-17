
@interface BCTab : UIButton {
	UIImage *background;
	UIImage *rightBorder;
	int currentbuttonIndex;
}

- (id)initWithIconImageName:(NSString *)imageName labelName:(NSString *)label1;

@end
