@STATIC;1.0;I;21;Foundation/CPObject.jt;8355;





objj_executeFile("Foundation/CPObject.j", NO);

{var the_class = objj_allocateClassPair(CPObject, "NewTemplate"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
class_addMethods(meta_class, [new objj_method(sel_getUid("data"), function $NewTemplate__data(self, _cmd)
{ with(self)
{
    var data2 = {
      rootpage: {
          type: 'Navigation',
          title: '',
          children : [
            {
              type: 'Navigation',
              title: 'Day 01',
              subtitle: '04 October, 2010',
              children : [
                {
                    type: 'Navigation',
                    title: 'Track A',
                    subtitle: 'This track is about topic X',
                    children : [
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '9:00 - 10:30 in Room 1',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        },
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '11:00 - 12:30 in Room 2',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        },
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '14:00 - 15:30 in Room 3',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        }
                    ]
                },
                {
                    type: 'Navigation',
                    title: 'Track B',
                    subtitle: 'This track is about topic Y',
                    children : [
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '9:00 - 10:30 in Room 2',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        },
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '11:00 - 12:30 in Room 3',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        },
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '14:00 - 15:30 in Room 1',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        }
                    ]
                }
              ]
            },
            {
              type: 'Navigation',
              title: 'Day 02',
              subtitle: '05 October, 2010',
              children : [
                {
                    type: 'Navigation',
                    title: 'Track A',
                    subtitle: 'This track is about topic X',
                    children : [
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '9:00 - 10:30 in Room 1',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        },
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '11:00 - 12:30 in Room 2',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        },
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '14:00 - 15:30 in Room 3',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        }
                    ]
                }
              ]
            },
            {
              type: 'Navigation',
              title: 'Day 03',
              subtitle: '06 October, 2010',
              children : [
                {
                    type: 'Navigation',
                    title: 'Track A',
                    subtitle: 'This track is about topic X',
                    children : [
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '9:00 - 10:30 in Room 1',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        },
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '11:00 - 12:30 in Room 2',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        },
                        {
                            type: 'Detail',
                            title: 'A great session',
                            subtitle: '14:00 - 15:30 in Room 3',
                            attributes : {
                                Speaker: 'Some speaker',
                                Desc: 'A detailed description about his session',
                                Link: 'http://www.agendium.de'
                            },
                            children : []
                        }
                    ]
                }
              ]
            }
          ]
      }
    };
    return JSON.stringify(data2);
}
},["id"])]);
}

