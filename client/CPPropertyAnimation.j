/*
 * CPPropertyAnimation.j
 * AppKit
 *
 * Created by Nicholas Small.
 * Copyright 2009, Nicholas Small.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

@import <AppKit/CPAnimation.j>


/*
  A VERY basic, but functional, property animation for Cappuccino. This is not CoreAnimation,
  nor anything similar. However, it will handle some basic property animations, and
  more can easily be added.
*/
@implementation CPPropertyAnimation : CPAnimation
{
	CPView			view;
	CPDictionary	properties;
	
	CPView			_startView;
	BOOL			_endView;
    CGRect          _startFrame;
    id              _finalDelegate;
    CPString        direction @accessors;
}

+ (CPPropertyAnimation) slideLeft:(id)delegate view:(id)view {
        var frame = [view frame];
        var offLeft = CGRectMake(frame.origin.x - frame.size.width, 
                                 frame.origin.y, 
                                 frame.size.width, 
                                 frame.size.height);
        var outAnimation = [[CPPropertyAnimation alloc] initWithView:view];
        outAnimation.direction = @"left";
        [outAnimation setDelegate:outAnimation];
        [outAnimation addProperty:@"frame" start:frame end:offLeft];
        _finalDelegate = delegate;
        return outAnimation;
}

+ (CPPropertyAnimation) slideRight:(id)delegate view:(id)view {
        var frame = [view frame];
        var offRight = CGRectMake(frame.origin.x + frame.size.width, 
                                 frame.origin.y, 
                                 frame.size.width, 
                                 frame.size.height);
        var outAnimation = [[CPPropertyAnimation alloc] initWithView:view];
        outAnimation.direction = @"right";
        [outAnimation setDelegate:outAnimation];
        [outAnimation addProperty:@"frame" start:frame end:offRight];
        _finalDelegate = delegate;
        return outAnimation;
}
 
- (id)initWithView:(CPView)aView
{
	self = [super initWithDuration:0.4 animationCurve:CPAnimationEaseOut];

	if (self)
	{
		view = aView;
        _startFrame = CGRectMakeCopy([aView frame]);
		properties = [CPDictionary dictionary];
	}
	
	return self;
}

-(void)animationDidEnd:(CPAnimation)animation {
        var rect;
        if(animation.direction === 'left'){
        rect = CGRectMake(_startFrame.origin.x + _startFrame.size.width, 
                                 _startFrame.origin.y, 
                                 _startFrame.size.width, 
                                 _startFrame.size.height);
        } else {
        rect = CGRectMake(_startFrame.origin.x - _startFrame.size.width, 
                                 _startFrame.origin.y, 
                                 _startFrame.size.width, 
                                 _startFrame.size.height);
        }
        var inAnimation = [[CPPropertyAnimation alloc] initWithView:view];
        [inAnimation setDelegate:_finalDelegate];
        [inAnimation addProperty:@"frame" start:rect end:_startFrame];
        [inAnimation startAnimation];
}

- (CPView)view
{
	return view;
}

- (void)addProperty:(CPString)aPath start:(CPValue)aStart end:(CPValue)anEnd
{
	if (![view respondsToSelector:aPath])
		return;

	[properties setObject:{start: aStart, end:anEnd} forKey:aPath];
	
	[view setValue:aStart forKey:aPath];
}

- (void)addToViewOnStart:(CPView)aView
{
	_startView = aView;
}

- (CPView)willAddToViewOnStart
{
	return _startView;
}

- (void)removeFromSuperviewOnEnd:(BOOL)aFlag
{
	_endView = aFlag;
}

- (BOOL)willRemoveFromSuperviewOnEnd
{
	return _endView;
}

- (void)setCurrentProgress:(float)progress
{
	[super setCurrentProgress:progress];
	
	var progress = [self currentValue];
	
	var keys = [properties allKeys],
		count = [keys count];
	
	for (var i = 0; i < count; i++)
	{
		var keyPath = keys[i],
			property = [properties objectForKey:keyPath];
		
		if (!property)
			continue;
		
		var start = property.start,
			end = property.end,
			value;
		
		if (keyPath == 'width' || keyPath == 'height')
			value = (progress * (end - start)) + start;
		else if (keyPath == 'size')
			value = CGSizeMake((progress * (end.width - start.width)) + start.width, (progress * (end.height - start.height)) + start.height);
		else if (keyPath == 'frame')
		{
			value = CGRectMake(
				(progress * (end.origin.x - start.origin.x)) + start.origin.x, 
				(progress * (end.origin.y - start.origin.y)) + start.origin.y,
				(progress * (end.size.width - start.size.width)) + start.size.width, 
				(progress * (end.size.height - start.size.height)) + start.size.height);
		}
		else if (keyPath == 'alphaValue')
			value = (progress * (end - start)) + start;
		else if (keyPath == 'backgroundColor' || keyPath == 'textColor' || keyPath == 'textShadowColor')
		{
		    var red = (progress * ([end redComponent] - [start redComponent])) + [start redComponent],
		        green = (progress * ([end greenComponent] - [start greenComponent])) + [start greenComponent],
		        blue = (progress * ([end blueComponent] - [start blueComponent])) + [start blueComponent],
		        alpha = (progress * ([end alphaComponent] - [start alphaComponent])) + [start alphaComponent];
		    
		    value = [CPColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
		}
		
		[view setValue:value forKey:keyPath];
	}
}

- (void)startAnimation
{
	var count = [properties count];
	for (var i = 0; i < count; i++)
	{
		var keyPath = [properties allKeys][i],
			property = [properties objectForKey:keyPath];
		
		if (!property)
			continue;
		
		[view setValue:property.start forKey:keyPath];
	}
	
	if (_startView)
		[_startView addSubview:view];
	
	[super startAnimation];
}

- (void)animationTimerDidFire:(CPTimer)aTimer
{
    [super animationTimerDidFire:aTimer];
    
	if (_progress === 1.0 && _endView)
		[view removeFromSuperview];
}

@end