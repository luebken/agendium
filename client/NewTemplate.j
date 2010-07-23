/* 
 * The template data
 */

@import <Foundation/CPObject.j>

@implementation NewTemplate : CPObject
{
}

+ (id) data {
    var data2 = { 
      rootpage: { 
          type: 'Navigation',
          title: '',
          children : [
            {
              type: 'Detail',
              title: 'News',
              subtitle: 'Update: 12.12. / 9:00',
              children : [],
              attributes : {
                  Info: 'This is a perfect place to put in some information about agenda changes.'
              }
            },
            {
              type: 'Spacer',
              title: 'Conference',
              subtitle: '',
              children : []
            },
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
          ,
          {
            type: 'Spacer',
            title: '',
            subtitle: '',
            children : []
          },
          {
            type: 'Navigation',
            title: 'Infos',
            subtitle: 'General information',
            children : []
          }]
      }
    };
    return JSON.stringify(data2);
}

@end