@STATIC;1.0;I;21;Foundation/CPObject.jt;413;


objj_executeFile("Foundation/CPObject.j", NO);

{var the_class = objj_allocateClassPair(CPViewController, "PageViewController"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("testMethod:"), function $PageViewController__testMethod_(self, _cmd, sender)
{ with(self)
{
    console.log('action from ' + sender);
}
},["@action","id"])]);
}

