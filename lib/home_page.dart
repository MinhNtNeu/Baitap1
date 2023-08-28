import 'dart:async';
import 'package:besoul/model/introduce_model.dart';
import 'package:besoul/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'model/images.dart';
import 'model/typemodel.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:  ThemeData(scaffoldBackgroundColor:  const Color(0xFFF6F6F6)),
      home: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _IntroduceWidget(),
                _TypeWidget(),
                SizedBox(height: 10,),
                _ProductWidget(),
                SizedBox(height: 10,),
                _Product1Widget(),
                SizedBox(height: 10,),
                _Product2Widget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IntroduceWidget extends StatefulWidget {
  const _IntroduceWidget({Key? key}) : super(key: key);

  @override
  State<_IntroduceWidget> createState() => _IntroduceWidgetState();
}

class _IntroduceWidgetState extends State<_IntroduceWidget> {
  List<IntroduceModel> intro = [
    IntroduceModel(image: 'assets/img1.png', status: '화장품을 제공하는 전자 상거래'),
    IntroduceModel(image: 'assets/2.png', status: '화장품을 제공하는 전자 상거래', introduce: '빠른 - 보장 - 명성'),
    IntroduceModel(image: 'assets/2.jpg', status: '화장품을 제공하는 전자 상거래 ', introduce: '빠른 - 보장 - 명성'),
    IntroduceModel(image: 'assets/1.jpg', status: ' 화장품을 제공하는 전자 상거래'),
  ];
  int selectedindex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;
  bool _isUserScrolling = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_handlePageScroll);
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_isUserScrolling) {
        int nextPage = selectedindex + 1;
        if (nextPage >= intro.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 30),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_handlePageScroll);
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _handlePageScroll() {
    if (_pageController.page == _pageController.page?.round()) {
      setState(() {
        selectedindex = _pageController.page?.round() ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 445,
          width: 448.84,
          child: NotificationListener<ScrollStartNotification>(
            onNotification: (_) {
              setState(() {
                _isUserScrolling = true;
              });
              return false;
            },
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (_) {
                setState(() {
                  _isUserScrolling = false;
                });
                return false;
              },
              child: PageView.builder(
                controller: _pageController,
                itemCount: intro.length,
                itemBuilder: (ctx, idx) {
                  var x = intro[idx];
                  return Stack( children: [
                    Positioned.fill(
                      child: Image.asset(
                        x.image,
                        fit: BoxFit.fitHeight,
                        height: 300,
                      ),
                    ),
                    Positioned.fill(
                      child: Opacity(
                        opacity: 1,
                        child: Container(
                          color: const Color(0xFF5A798366),
                        ),
                      ),),
                    Positioned(
                        top: 10,
                        right: 10,
                        left: 10,
                        child: appbar()),
                    SizedBox(
                      width: 450,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(x.status,style: const TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w700),),
                          const SizedBox(height: 10,),
                          Text(x.introduce ?? " ",style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ),

                    Positioned(
                        top: 418,
                        left: 325,
                        child:
                        Container(
                          width: 24,
                            height: 16,
                            decoration: const BoxDecoration(
                                color: Color(0xFF8E9A9F),
                                borderRadius: BorderRadius.all(Radius.circular(4))
                            ),
                            child: Center(child: Text('${(idx + 1)}/${intro.length}',style: const TextStyle(color: Colors.white),)))),

                    Positioned(
                      top: 426,
                      left: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                          intro.length,
                              (index) => Container(
                            width: 24,
                            height: selectedindex == index ? 3 : 1,
                            decoration: BoxDecoration(
                             borderRadius: const BorderRadius.all(Radius.circular(4)),
                              color: selectedindex == index
                                  ? Colors.white
                                  : Colors.white38,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  );
                },
              ),
            ),
          ),


    );
  }
  Widget appbar(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Tất cả ",style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w600),),
            const Text("Best ",style: TextStyle(fontSize: 14,color: Color(0xFFE7E7E7),fontWeight: FontWeight.w400),),
            const Text("Best review ",style: TextStyle(fontSize: 14,color: Color(0xFFE7E7E7),fontWeight: FontWeight.w400),),
            const Text("Event ",style: TextStyle(fontSize: 14,color: Color(0xFFE7E7E7),fontWeight: FontWeight.w400),),
            SvgPicture.asset('assets/w_search.svg'),
            SvgPicture.asset('assets/goods.svg'),
          ],
        ),
        const SizedBox(height: 15,),
        Container(
          width: 358,
          height: 1,
          color: Colors.white,
        )
      ],
    );
  }
}

class _TypeWidget extends StatefulWidget {
  const _TypeWidget({Key? key}) : super(key: key);

  @override
  State<_TypeWidget> createState() => _TypeWidgetState();
}

class _TypeWidgetState extends State<_TypeWidget> {
  List<TypeModel> type =[
    TypeModel(image: 'assets/beautiful.png', name: 'Beauty'),
    TypeModel(image: 'assets/fashion.png', name: 'Fashion'),
    TypeModel(image: 'assets/healthy.png', name: 'Healthy'),
    TypeModel(image: 'assets/beauty1.png', name: 'Beauty Tip'),
  ];
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100,
      color: const Color(0xFFE0E0E0),
      margin: const EdgeInsets.only(left: 0, right: 0),
      child: Center(
        child: ListView.separated(
            separatorBuilder: (ctx, idx) {
              return Container(
                width: 8,
              );
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: type.length,
            itemBuilder: (ctx, idx) {
              var y = type[idx];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(y.image,height: 70,width: 70,),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    y.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w400),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
class _ProductWidget extends StatefulWidget {
  const _ProductWidget({Key? key}) : super(key: key);

  @override
  State<_ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<_ProductWidget> {
  List<ProductModel> product =[
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),

  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Sản Phẩm Dành Cho Bạn",style: TextStyle(fontSize: 20,color: Color(0xFF4AA98B),fontWeight: FontWeight.w600),),
                    SvgPicture.asset(chuyen),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 560,
                  child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.6,
                  children: List.generate(
                  product.length, (idx) {
                    var y = product[idx];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                      width: 160,
                      height: 190,
                      child: Image.asset(y.image,fit: BoxFit.cover,)),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(
                                width: 105,
                                child: Row(
                                  children: [
                                    Image.asset(y.evaluate,height: 12,width: 50,),
                                    Text(' (${y.amount})',style: const TextStyle(fontSize: 10,color: Color(0xFF949494)),),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 4,),
                              Text(y.comment,style: const TextStyle(fontSize: 10,color: Color(0xFF949494)),),

                            ],

                          ),
                          Text(y.name, style: const TextStyle(fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2E2E2E)),),
                          const SizedBox(height: 4,),
                          Row(
                            children: [
                              SizedBox(
                                width:60,
                                child: Text(y.discount, style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Color(0xFF818181),fontSize: 10),),
                              ),
                              SizedBox(
                                width: 95,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(y.price,style: const TextStyle(fontSize: 10,color: Colors.black),),
                                    Text(y.quantity,style: const TextStyle(fontSize: 10,color: Color(0xFF8D8D8D)),),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  ),
                ),
                Container(
                  width: 339,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(1),),
                      border: Border.all(
                          color: const Color(0xFFE8E8E8),
                          width: 1
                      )
                  ),
                  child: const Center(
                    child: Text("Xem thêm",style: TextStyle(color: Color(0xFF6F6F6F),fontSize: 13,fontWeight: FontWeight.w500),),
                  ),
                )],
            ),
        ),
      ),
    );
  }
}
class _Product1Widget extends StatefulWidget {
  const _Product1Widget({Key? key}) : super(key: key);

  @override
  State<_Product1Widget> createState() => _Product1WidgetState();
}

class _Product1WidgetState extends State<_Product1Widget> {
  List<ProductModel> product =[
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),

  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Sản phẩm được yêu thích nhất",style: TextStyle(fontSize: 20,color: Color(0xFF4AA98B),fontWeight: FontWeight.w600),),
                  SvgPicture.asset(chuyen),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 560,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.6,
                  children: List.generate(
                      product.length, (idx) {
                    var y = product[idx];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 160,
                              height: 190,
                              child: Image.asset(y.image,fit: BoxFit.cover,)),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(
                                width: 105,
                                child: Row(
                                  children: [
                                    Image.asset(y.evaluate,height: 12,width: 50,),
                                    Text(' (${y.amount})',style: const TextStyle(fontSize: 10,color: Color(0xFF949494)),),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 4,),
                              Text(y.comment,style: const TextStyle(fontSize: 10,color: Color(0xFF949494)),),

                            ],

                          ),
                          Text(y.name, style: const TextStyle(fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2E2E2E)),),
                          const SizedBox(height: 4,),
                          Row(
                            children: [
                              SizedBox(
                                width:60,
                                child: Text(y.discount, style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Color(0xFF818181),fontSize: 10),),
                              ),
                              SizedBox(
                                width: 95,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(y.price,style: const TextStyle(fontSize: 10,color: Colors.black),),
                                    Text(y.quantity,style: const TextStyle(fontSize: 10,color: Color(0xFF8D8D8D)),),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Container(
                width: 339,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(1),),
                    border: Border.all(
                        color: const Color(0xFFE8E8E8),
                        width: 1
                    )
                ),
                child: const Center(
                  child: Text("Xem thêm",style: TextStyle(color: Color(0xFF6F6F6F),fontSize: 13,fontWeight: FontWeight.w500),),
                ),
              )],
          ),
        ),
      ),
    );
  }
}
class _Product2Widget extends StatefulWidget {
  const _Product2Widget({Key? key}) : super(key: key);

  @override
  State<_Product2Widget> createState() => _Product2WidgetState();
}

class _Product2WidgetState extends State<_Product2Widget> {
  List<ProductModel> product =[
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),
    ProductModel( image: 'assets/image 7.png', name: 'Son môi Shu - màu đỏ hồng 2022', comment: '7 nhân xét', discount: '200.000 đ', price: '120.000đ', quantity: '25 đã bán', amount: '120', evaluate: 'assets/star.jpg'),

  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Sản phẩm bán chạy nhất",style: TextStyle(fontSize: 20,color: Color(0xFF4AA98B),fontWeight: FontWeight.w600),),
                  SvgPicture.asset(chuyen),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 560,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.6,
                  children: List.generate(
                      product.length, (idx) {
                    var y = product[idx];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 160,
                              height: 190,
                              child: Image.asset(y.image,fit: BoxFit.cover,)),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(
                                width: 105,
                                child: Row(
                                  children: [
                                    Image.asset(y.evaluate,height: 12,width: 50,),
                                    Text(' (${y.amount})',style: const TextStyle(fontSize: 10,color: Color(0xFF949494)),),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 4,),
                              Text(y.comment,style: const TextStyle(fontSize: 10,color: Color(0xFF949494)),),

                            ],

                          ),
                          Text(y.name, style: const TextStyle(fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2E2E2E)),),
                          const SizedBox(height: 4,),
                          Row(
                            children: [
                              SizedBox(
                                width:60,
                                child: Text(y.discount, style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Color(0xFF818181),fontSize: 10),),
                              ),
                              SizedBox(
                                width: 95,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(y.price,style: const TextStyle(fontSize: 10,color: Colors.black),),
                                    Text(y.quantity,style: const TextStyle(fontSize: 10,color: Color(0xFF8D8D8D)),),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Container(
                width: 339,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(1),),
                    border: Border.all(
                        color: const Color(0xFFE8E8E8),
                        width: 1
                    )
                ),
                child: const Center(
                  child: Text("Xem thêm",style: TextStyle(color: Color(0xFF6F6F6F),fontSize: 13,fontWeight: FontWeight.w500),),
                ),
              )],
          ),
        ),
      ),
    );
  }
}
