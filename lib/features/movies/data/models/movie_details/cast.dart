class Cast {
 const Cast({
     required this.name,
     required this.characterName,
     required this.urlSmallImage,
     });

factory  Cast.fromJson(dynamic json) {
    return Cast(
      name: json['name']??'',
      characterName: json['character_name']??'',
      urlSmallImage: json['url_small_image']??'',
    );

  }
 final String name;
 final String characterName;
 final String urlSmallImage;


}