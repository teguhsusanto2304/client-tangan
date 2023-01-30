class SliderModel{
  String image;
  String title;
  String desc;

// images given
  SliderModel({required this.image,required this.title,required this.desc});

// setter for image
  void setImage(String getImage){
    image = getImage;
  }

// getter for image
  String getImage(){
    return image;
  }
  void setTitle(String getTitle){
    title = getTitle;
  }
  String getTitle(){
    return title;
  }
  void setDesc(String getDesc){
    desc = getDesc;
  }
  String getDesc(){
    return desc;
  }
}
List<SliderModel> getSlides(){
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = SliderModel(image: '',title: '',desc: '');

// 1
  sliderModel.setImage("assets/images/tangan.png");
  sliderModel.setTitle("tangan hadir sebagai solusi hal-hal yang bisa bantu kamu");
  sliderModel.setDesc("Kamu sekarang bisa minta bantuan apa aja dalam berbagai macam kategori");
  slides.add(sliderModel);

  sliderModel = SliderModel(image: '',title: '',desc: '');

// 2
  sliderModel.setImage("assets/images/people-work.png");
  sliderModel.setTitle("tangan hadir sebagai solusi hal-hal yang bisa bantu kamu");
  sliderModel.setDesc("Kamu sekarang bisa minta bantuan apa aja dalam berbagai macam kategori");
  slides.add(sliderModel);

  sliderModel = SliderModel(image: '',title: '',desc: '');

// 3
  sliderModel.setImage("assets/images/bolham-idea.png");
  sliderModel.setTitle("tangan hadir sebagai solusi hal-hal yang bisa bantu kamu");
  sliderModel.setDesc("Kamu sekarang bisa minta bantuan apa aja dalam berbagai macam kategori");
  slides.add(sliderModel);

  sliderModel = SliderModel(image: '',title: '',desc: '');
  return slides;
}
