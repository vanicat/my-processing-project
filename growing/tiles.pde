PImage[] tiles = new PImage[10*10];

final int rootTiles = 15;
final int waterTiles = 9;
final int trunkTiles = 11;
final int groundTiles = 10;
final int easyDirtTiles = 0;
final int DirtTiles = 3;
final int rockTiles = 4;

class Carte {
  JSONObject data;
  int height;
  int width;
  String name;
  JSONArray themap;
  JSONArray objects;

  Carte(String name) {
    data = loadJSONObject(name);
    name = data.getString("name");
    height = data.getInt("height");
    width  = data.getInt("width");
    for(int i = 0; i<2; i++) {
      JSONObject tmp = data.getJSONArray("layers").getJSONObject(i);
      if(tmp.getString("name") == "le plan") {
        themap = tmp.getJSONArray("data");
      } else {
        objects = tmp.getJSONArray("objects");
      }
    }
  }

  int get(int x, int y) {
    return themap.getInt(x+height*y);
  }


}