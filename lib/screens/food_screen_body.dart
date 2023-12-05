

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app_1/utils/dimension.dart';



class FoodScreenBody extends StatefulWidget {
  const FoodScreenBody({super.key});

  @override
  State<FoodScreenBody> createState() => _FoodScreenBodyState();
}

class _FoodScreenBodyState extends State<FoodScreenBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currPageValue = 0.0;
  double scaleFactor = 8.0;
  double height = Dimension.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispoos() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// slider section
        Container(
          //color: Colors.redAccent,
          height: Dimension.pageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        SizedBox(height: 10,),
        Container(
            margin: EdgeInsets.only(left: 30),
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Populer',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child : Text('.',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                ),
                SizedBox(width: 10,),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child : Text('Food pairing',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                ),
              ],
            )
        ),
        /// list food and images
        Container(
          height: 900,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            //shrinkWrap: true,
            //scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
                child: Row(
                  children: [
                    /// image section
                    Container(
                      height : 120,
                      width : 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage('https://github.com/Mansurisodev/food_delivery/blob/master/assets/images/food0.png?raw=true'),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    /// text container
                    Expanded(
                      child: Container(
                        height : 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Nutirions fruit meal in China',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                              SizedBox(height: 10,),
                              Text('With chinese characteristics',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.circle_sharp,
                                    color: Color(
                                      0xFFFFCD81,
                                    ),
                                  ),
                                  Text('Normal'),
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: Color(
                                      0xFF8BDBD1,
                                    ),
                                  ),
                                  Text('1.7km'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.access_time_rounded,
                                    color: Color(
                                      0xFFFFCD81,
                                    ),
                                  ),
                                  Text('32min'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },),
        ),

        /// dost
        DotsIndicator(
          dotsCount: 5,
          position: currPageValue.toInt(),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        /// popular text
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();

    if (index == currPageValue.floor()) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, scaleFactor, 1)
        ..setTranslationRaw(0, currTrans, 0);

    } else if (index == currPageValue.floor() + 1) {
      var currScale = scaleFactor + (currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, scaleFactor, 1);
      matrix = Matrix4.diagonal3Values(1, scaleFactor, 1)
        ..setTranslationRaw(0, currTrans, 0);

    } else if (index == currPageValue.floor() - 1) {
      var currScale = scaleFactor + (currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, scaleFactor, 1);
      matrix = Matrix4.diagonal3Values(1, scaleFactor, 1)
        ..setTranslationRaw(0, currTrans, 0);

    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, scaleFactor, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 1);
    }

    return Stack(
      children: [
        Container(
          height: Dimension.pageViewContainer,
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(31),
              color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                  image: NetworkImage(
                      'https://github.com/Mansurisodev/food_delivery/blob/master/assets/images/food0.png?raw=true'),
                  fit: BoxFit.fill)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimension.pageViewTextContainer,
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 0.5,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0))
                ]),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chinese Side',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: Colors.green,
                              size: 15,
                            );
                          }),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '4.5',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '1278',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'comment',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.circle_sharp,
                          color: Color(
                            0xFFFFCD81,
                          ),
                        ),
                        Text('Normal'),
                        Icon(
                          Icons.location_on_rounded,
                          color: Color(
                            0xFF8BDBD1,
                          ),
                        ),
                        Text('1.7km'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.access_time_rounded,
                          color: Color(
                            0xFFFFCD81,
                          ),
                        ),
                        Text('32min'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
