@STATIC;1.0;I;20;AppKit/CPAnimation.jt;8433;objj_executeFile("AppKit/CPAnimation.j", NO);
{var the_class = objj_allocateClassPair(CPAnimation, "CPPropertyAnimation"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("view"), new objj_ivar("properties"), new objj_ivar("_startView"), new objj_ivar("_endView"), new objj_ivar("_startFrame"), new objj_ivar("_finalDelegate"), new objj_ivar("direction")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("direction"), function $CPPropertyAnimation__direction(self, _cmd)
{ with(self)
{
return direction;
}
},["id"]),
new objj_method(sel_getUid("setDirection:"), function $CPPropertyAnimation__setDirection_(self, _cmd, newValue)
{ with(self)
{
direction = newValue;
}
},["void","id"]), new objj_method(sel_getUid("initWithView:"), function $CPPropertyAnimation__initWithView_(self, _cmd, aView)
{ with(self)
{
 self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPPropertyAnimation").super_class }, "initWithDuration:animationCurve:", 0.4, CPAnimationEaseOut);
 if (self)
 {
  view = aView;
        _startFrame = CGRectMakeCopy(objj_msgSend(aView, "frame"));
  properties = objj_msgSend(CPDictionary, "dictionary");
 }
 return self;
}
},["id","CPView"]), new objj_method(sel_getUid("animationDidEnd:"), function $CPPropertyAnimation__animationDidEnd_(self, _cmd, animation)
{ with(self)
{
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
        var inAnimation = objj_msgSend(objj_msgSend(CPPropertyAnimation, "alloc"), "initWithView:", view);
        objj_msgSend(inAnimation, "setDelegate:", _finalDelegate);
        objj_msgSend(inAnimation, "addProperty:start:end:", "frame", rect, _startFrame);
        objj_msgSend(inAnimation, "startAnimation");
}
},["void","CPAnimation"]), new objj_method(sel_getUid("view"), function $CPPropertyAnimation__view(self, _cmd)
{ with(self)
{
 return view;
}
},["CPView"]), new objj_method(sel_getUid("addProperty:start:end:"), function $CPPropertyAnimation__addProperty_start_end_(self, _cmd, aPath, aStart, anEnd)
{ with(self)
{
 if (!objj_msgSend(view, "respondsToSelector:", aPath))
  return;
 objj_msgSend(properties, "setObject:forKey:", {start: aStart, end:anEnd}, aPath);
 objj_msgSend(view, "setValue:forKey:", aStart, aPath);
}
},["void","CPString","CPValue","CPValue"]), new objj_method(sel_getUid("addToViewOnStart:"), function $CPPropertyAnimation__addToViewOnStart_(self, _cmd, aView)
{ with(self)
{
 _startView = aView;
}
},["void","CPView"]), new objj_method(sel_getUid("willAddToViewOnStart"), function $CPPropertyAnimation__willAddToViewOnStart(self, _cmd)
{ with(self)
{
 return _startView;
}
},["CPView"]), new objj_method(sel_getUid("removeFromSuperviewOnEnd:"), function $CPPropertyAnimation__removeFromSuperviewOnEnd_(self, _cmd, aFlag)
{ with(self)
{
 _endView = aFlag;
}
},["void","BOOL"]), new objj_method(sel_getUid("willRemoveFromSuperviewOnEnd"), function $CPPropertyAnimation__willRemoveFromSuperviewOnEnd(self, _cmd)
{ with(self)
{
 return _endView;
}
},["BOOL"]), new objj_method(sel_getUid("setCurrentProgress:"), function $CPPropertyAnimation__setCurrentProgress_(self, _cmd, progress)
{ with(self)
{
 objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPPropertyAnimation").super_class }, "setCurrentProgress:", progress);
 var progress = objj_msgSend(self, "currentValue");
 var keys = objj_msgSend(properties, "allKeys"),
  count = objj_msgSend(keys, "count");
 for (var i = 0; i < count; i++)
 {
  var keyPath = keys[i],
   property = objj_msgSend(properties, "objectForKey:", keyPath);
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
      var red = (progress * (objj_msgSend(end, "redComponent") - objj_msgSend(start, "redComponent"))) + objj_msgSend(start, "redComponent"),
          green = (progress * (objj_msgSend(end, "greenComponent") - objj_msgSend(start, "greenComponent"))) + objj_msgSend(start, "greenComponent"),
          blue = (progress * (objj_msgSend(end, "blueComponent") - objj_msgSend(start, "blueComponent"))) + objj_msgSend(start, "blueComponent"),
          alpha = (progress * (objj_msgSend(end, "alphaComponent") - objj_msgSend(start, "alphaComponent"))) + objj_msgSend(start, "alphaComponent");
      value = objj_msgSend(CPColor, "colorWithCalibratedRed:green:blue:alpha:", red, green, blue, alpha);
  }
  objj_msgSend(view, "setValue:forKey:", value, keyPath);
 }
}
},["void","float"]), new objj_method(sel_getUid("startAnimation"), function $CPPropertyAnimation__startAnimation(self, _cmd)
{ with(self)
{
 var count = objj_msgSend(properties, "count");
 for (var i = 0; i < count; i++)
 {
  var keyPath = objj_msgSend(properties, "allKeys")[i],
   property = objj_msgSend(properties, "objectForKey:", keyPath);
  if (!property)
   continue;
  objj_msgSend(view, "setValue:forKey:", property.start, keyPath);
 }
 if (_startView)
  objj_msgSend(_startView, "addSubview:", view);
 objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPPropertyAnimation").super_class }, "startAnimation");
}
},["void"]), new objj_method(sel_getUid("animationTimerDidFire:"), function $CPPropertyAnimation__animationTimerDidFire_(self, _cmd, aTimer)
{ with(self)
{
    objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPPropertyAnimation").super_class }, "animationTimerDidFire:", aTimer);
 if (_progress === 1.0 && _endView)
  objj_msgSend(view, "removeFromSuperview");
}
},["void","CPTimer"])]);
class_addMethods(meta_class, [new objj_method(sel_getUid("slideLeft:view:"), function $CPPropertyAnimation__slideLeft_view_(self, _cmd, delegate, view)
{ with(self)
{
        var frame = objj_msgSend(view, "frame");
        var offLeft = CGRectMake(frame.origin.x - frame.size.width,
                                 frame.origin.y,
                                 frame.size.width,
                                 frame.size.height);
        var outAnimation = objj_msgSend(objj_msgSend(CPPropertyAnimation, "alloc"), "initWithView:", view);
        outAnimation.direction = "left";
        objj_msgSend(outAnimation, "setDelegate:", outAnimation);
        objj_msgSend(outAnimation, "addProperty:start:end:", "frame", frame, offLeft);
        _finalDelegate = delegate;
        return outAnimation;
}
},["CPPropertyAnimation","id","id"]), new objj_method(sel_getUid("slideRight:view:"), function $CPPropertyAnimation__slideRight_view_(self, _cmd, delegate, view)
{ with(self)
{
        var frame = objj_msgSend(view, "frame");
        var offRight = CGRectMake(frame.origin.x + frame.size.width,
                                 frame.origin.y,
                                 frame.size.width,
                                 frame.size.height);
        var outAnimation = objj_msgSend(objj_msgSend(CPPropertyAnimation, "alloc"), "initWithView:", view);
        outAnimation.direction = "right";
        objj_msgSend(outAnimation, "setDelegate:", outAnimation);
        objj_msgSend(outAnimation, "addProperty:start:end:", "frame", frame, offRight);
        _finalDelegate = delegate;
        return outAnimation;
}
},["CPPropertyAnimation","id","id"])]);
}

