import 'package:flutter/material.dart';

import 'main_model.dart';

class HomePage extends StatefulWidget {
  final MainModel data ;
  const HomePage({Key? key, required this.data}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController tabController ;
  late final ScrollController controller = ScrollController()
    ..addListener(() {
      if (controller.hasClients) {
        int index = getIndexFromOffset(controller.offset-270);
        if(index !=tabController.index){
          tabController.animateTo(index < 0 ? 0 : index);
          setState(() {});
        }

      }
    });
 

  MainModel? mainModel;
  Map<String,int> map ={};

  @override
  void initState() {
    mainModel = widget.data;
    print(mainModel!.toJson());
    tabController = TabController(length: mainModel!.maincategory.length, vsync: this);
    tapMap();
    super.initState();
  }
  tapMap(){
    for(var i =0 ; i<mainModel!.maincategory.length; i++){
      String model = mainModel!.maincategory[i];
      if(i == 0){
        map[model]=0;
      }else{
        List<SubModel> subList = mainModel!.subcategory.where((element) => element.category == mainModel!.maincategory[i-1],).toList();
        map[model] = (subList.length)*160 +map[ mainModel!.maincategory[i-1]]!;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainModel!.mainColor!),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return CustomScrollView(
            controller: controller,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  color: mainModel!.mainColor!.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      height: 125,
                      width: 125,
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(1, -1))],
                          borderRadius: BorderRadius.circular(15),image: DecorationImage(image: NetworkImage(mainModel!.profileimg.toString()))),
                      child: SizedBox(),
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                centerTitle: false,
                title: Text(
                  mainModel!.name.toString(),
                  style: TextStyle(fontSize: 23),
                ),
                actions: [
                  Icon(Icons.wechat_sharp,color: Colors.green,size: 30,),
                  SizedBox(width: 20,),
                  Icon(Icons.facebook_outlined,color: Colors.blue,size: 30,),
                  SizedBox(width: 20,),
                ],
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TabBar(
                          tabAlignment: TabAlignment.start,
                          isScrollable: true,
                          onTap: onTapTab,
                          controller: tabController,
                          padding: EdgeInsets.zero,
                          tabs: List.generate(
                              mainModel!.maincategory.length,
                                  (index) => Container(
                                width: 75,
                                height: 40,
                                alignment: Alignment.center,
                                // color: index == tabController.index ? Colors.deepOrange : Colors.cyanAccent,
                                child: Text(mainModel!.maincategory[index]),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: mainModel!.maincategory.length,
                      (context, index) {
                    List<SubModel> subList = mainModel!.subcategory.where((element) => element.category == mainModel!.maincategory[index],).toList();
                    return Container(
                      // height: itemHeight,
                      //  color: index.isEven ? Colors.green.withOpacity(0.5) : Colors.pink.withOpacity(0.5),
                      width: constraints.maxWidth,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mainModel!.maincategory[index],
                            style: TextStyle(fontSize: 24),
                          ),
                          for (SubModel model in subList)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    //  color: Colors.red,
                                    height: 150,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.name.toString(),
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Expanded(child: Text( model.des.toString() * 10)),
                                              Text(
                                                model.price.toString()+" SYR",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          height: 100,
                                          width: 100,
                                          child:Image.network(model.img.toString()),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.grey.shade200,
                                )
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
 int getIndexFromOffset(double offset,) {
    if(offset> map.values.last){
      return map.length-1;
    }
    for (int i = 0; i < map.length; i++) {
      List<MapEntry<String,int>> list=map.entries.toList();
      if(i==0){

      }
      else if(offset >list[i-1].value &&offset <list[i].value ){
        return i-1;
      }
    }
    return 0;
  }
  onTapTab(int index) {
    controller.jumpTo(((65*index) + (map[mainModel!.maincategory[index]]!) + 200).toDouble());
  }

}
