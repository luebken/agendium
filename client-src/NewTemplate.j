/* 
 * The template data
 */

@import <Foundation/CPObject.j>

var MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
var WEEKDAYS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

@implementation NewTemplate : CPObject
{
}

+ (CPString) stantardDateFormat: (CPDate)dt {
    var weekday = WEEKDAYS[(dt.getDay() + 6) % 7];    
    return [CPString stringWithFormat:@"%s, %02d %s %04d", weekday, dt.getDate(), MONTHS[dt.getMonth()], dt.getFullYear()];
}

+ (CPString) dateFormatForUpdate: (CPDate)dt {
    return [CPString stringWithFormat:@"Update: %02d. %s.", dt.getDate(), MONTHS[dt.getMonth()]];
}

+ (id) jsonDataForTemplate: (CPString) template withStartingDate:(CPDate) date {
    if(template == 'onedayonetrack') {
        return [NewTemplate dataonedayonetrack:new Date() withFirstDate:date];
    } else {
        return [NewTemplate datathreedaystwotracks:new Date() withFirstDate:date];
    }
}
+ (id) dataonedayonetrack:(CPDate)now withFirstDate:(CPDate)firstDate {
    var stantardDate = [NewTemplate stantardDateFormat:firstDate];
    var updateDate = [NewTemplate dateFormatForUpdate:now];
    
    var data2 = { 
      rootpage: { 
          type: 'Navigation',
          title: '',
          children : [
            {
              type: 'Detail',
              title: 'News',
              subtitle: updateDate,
              children : [],
              attributes : [
                  {'key':'Info', 'value':'This is a perfect place to put in some information about agenda changes.'}
              ]
            },
            {
              type: 'Spacer',
              title: 'Conference',
              subtitle: '',
              children : [ ]
            },
            {
              type: 'Navigation',
              title: 'Sessions',
              subtitle: stantardDate,
              children : [
                  {
                      type: 'Detail',
                      title: 'A great session',
                      subtitle: '9:00 - 10:30 in Room 1',
                      attributes : [
                          {'key':'Speaker','value':'Some speaker'},
                          {'key':'Desc','value':'A detailed description about his session'},
                          {'key':'Link','value':'http://www.agendium.de'}
                      ],
                      children : []
                  },
                  {
                      type: 'Detail',
                      title: 'A great session',
                      subtitle: '11:00 - 12:30 in Room 2',
                      attributes : [
                      ],
                      children : []
                  },
                  {
                      type: 'Detail',
                      title: 'A great session',
                      subtitle: '14:00 - 15:30 in Room 3',
                      attributes : [
                      ],
                      children : []
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
+ (id) datathreedaystwotracks:(CPDate)now withFirstDate:(CPDate)firstDate {
    var firstDay = [NewTemplate stantardDateFormat:firstDate];
    firstDate.setDate(firstDate.getDate() + 1);
    var secondDay = [NewTemplate stantardDateFormat:firstDate];
    firstDate.setDate(firstDate.getDate() + 1);
    var thirdDay = [NewTemplate stantardDateFormat:firstDate];
    var updateDate = [NewTemplate dateFormatForUpdate:now];
    
    var data2 = { 
      rootpage: { 
          type: 'Navigation',
          title: '',
          children : [
            {
              type: 'Detail',
              title: 'News',
              subtitle: updateDate,
              children : [],
              attributes : [
                  {'key':'Info', 'value':'This is a perfect place to put in some information about agenda changes.'}
              ]
            },
            {
              type: 'Spacer',
              title: 'Conference',
              subtitle: '',
              children : [ ]
            }  ,
              {
                type: 'Navigation',
                title: 'Day 01',
                subtitle: firstDay,
                children : [
                          {
                              type: 'Spacer',
                              title: 'Morning',
                              subtitle: '',
                              children : [ ]
                          },
                          {
                              type: 'Detail',
                              title: 'First Session',
                              subtitle: 'Track A | 9:00-10:30',
                              attributes : [
                                  {'key':'Speaker','value':'Some speaker'},
                                  {'key':'Desc','value':'A detailed description about his session'},
                                  {'key':'Link','value':'http://www.agendium.de'}
                              ],
                              children : []
                          },
                          {
                              type: 'Detail',
                              title: 'Second Session',
                              subtitle: 'Track B | 9:00-10:30',
                              attributes : [
                                  {'key':'Speaker','value':'Some speaker'},
                                  {'key':'Desc','value':'A detailed description about his session'},
                                  {'key':'Link','value':'http://www.agendium.de'}
                              ],
                              children : []
                          },
                          {
                              type: 'Detail',
                              title: 'Third Session',
                              subtitle: 'Track A | 10:45-11:30',
                              attributes : [
                                  {'key':'Speaker','value':'Some speaker'},
                                  {'key':'Desc','value':'A detailed description about his session'},
                                  {'key':'Link','value':'http://www.agendium.de'}
                              ],
                              children : []
                          },
                          {
                              type: 'Detail',
                              title: 'Fourth Session',
                              subtitle: 'Track B | 10:45-11:30',
                              attributes : [
                                  {'key':'Speaker','value':'Some speaker'},
                                  {'key':'Desc','value':'A detailed description about his session'},
                                  {'key':'Link','value':'http://www.agendium.de'}
                              ],
                              children : []
                          },
                          {
                              type: 'Detail',
                              title: 'Lunch',
                              subtitle: '11:30-13:00',
                              attributes : [
                                  {'key':'Location','value':'Get great food and drinks down in the main area.'},
                                  {'key':'Exhibition','value':'Walk around the exhibition and meet great people.'}
                              ],
                              children : []
                          },
                          {
                              type: 'Spacer',
                              title: 'Afternoon',
                              subtitle: '',
                              children : [ ]
                          },
                          {
                              type: 'Detail',
                              title: 'Fifth Session',
                              subtitle: 'Track A | 13:00-14:30',
                              attributes : [
                                  {'key':'Speaker','value':'Some speaker'},
                                  {'key':'Desc','value':'A detailed description about his session'},
                                  {'key':'Link','value':'http://www.agendium.de'}
                              ],
                              children : []
                          },
                          {
                              type: 'Detail',
                              title: 'Sixth Session',
                              subtitle: 'Track B | 13:00-14:30',
                              attributes : [
                                  {'key':'Speaker','value':'Some speaker'},
                                  {'key':'Desc','value':'A detailed description about his session'},
                                  {'key':'Link','value':'http://www.agendium.de'}
                              ],
                              children : []
                          },
                          {
                              type: 'Detail',
                              title: 'Seventh Session',
                              subtitle: 'Track A | 15:00-16:30',
                              attributes : [
                                  {'key':'Speaker','value':'Some speaker'},
                                  {'key':'Desc','value':'A detailed description about his session'},
                                  {'key':'Link','value':'http://www.agendium.de'}
                              ],
                              children : []
                          },
                          {
                              type: 'Detail',
                              title: 'Eigth Session',
                              subtitle: 'Track B | 15:00-16:30',
                              attributes : [
                                  {'key':'Speaker','value':'Some speaker'},
                                  {'key':'Desc','value':'A detailed description about his session'},
                                  {'key':'Link','value':'http://www.agendium.de'}
                              ],
                              children : []
                          },

                      ] 
              },
                {
                  type: 'Navigation',
                  title: 'Day 02',
                  subtitle: secondDay,
                  children : [
                            {
                                type: 'Spacer',
                                title: 'Morning',
                                subtitle: '',
                                children : [ ]
                            },
                            {
                                type: 'Detail',
                                title: 'First Session',
                                subtitle: 'Track A | 9:00-10:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Second Session',
                                subtitle: 'Track B | 9:00-10:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Third Session',
                                subtitle: 'Track A | 10:45-11:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Fourth Session',
                                subtitle: 'Track B | 10:45-11:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Lunch',
                                subtitle: '11:30-13:00',
                                attributes : [
                                    {'key':'Location','value':'Get great food and drinks down in the main area.'},
                                    {'key':'Exhibition','value':'Walk around the exhibition and meet great people.'}
                                ],
                                children : []
                            },
                            {
                                type: 'Spacer',
                                title: 'Afternoon',
                                subtitle: '',
                                children : [ ]
                            },
                            {
                                type: 'Detail',
                                title: 'Fifth Session',
                                subtitle: 'Track A | 13:00-14:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Sixth Session',
                                subtitle: 'Track B | 13:00-14:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Seventh Session',
                                subtitle: 'Track A | 15:00-16:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Eigth Session',
                                subtitle: 'Track B | 15:00-16:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },

                        ] 
                },
                {
                  type: 'Navigation',
                  title: 'Day 03',
                  subtitle: thirdDay,
                  children : [
                            {
                                type: 'Spacer',
                                title: 'Morning',
                                subtitle: '',
                                children : [ ]
                            },
                            {
                                type: 'Detail',
                                title: 'First Session',
                                subtitle: 'Track A | 9:00-10:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Second Session',
                                subtitle: 'Track B | 9:00-10:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Third Session',
                                subtitle: 'Track A | 10:45-11:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Fourth Session',
                                subtitle: 'Track B | 10:45-11:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Lunch',
                                subtitle: '11:30-13:00',
                                attributes : [
                                    {'key':'Location','value':'Get great food and drinks down in the main area.'},
                                    {'key':'Exhibition','value':'Walk around the exhibition and meet great people.'}
                                ],
                                children : []
                            },
                            {
                                type: 'Spacer',
                                title: 'Afternoon',
                                subtitle: '',
                                children : [ ]
                            },
                            {
                                type: 'Detail',
                                title: 'Fifth Session',
                                subtitle: 'Track A | 13:00-14:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Sixth Session',
                                subtitle: 'Track B | 13:00-14:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Seventh Session',
                                subtitle: 'Track A | 15:00-16:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },
                            {
                                type: 'Detail',
                                title: 'Eigth Session',
                                subtitle: 'Track B | 15:00-16:30',
                                attributes : [
                                    {'key':'Speaker','value':'Some speaker'},
                                    {'key':'Desc','value':'A detailed description about his session'},
                                    {'key':'Link','value':'http://www.agendium.de'}
                                ],
                                children : []
                            },

                        ] 
                },
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