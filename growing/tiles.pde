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
    data = loadJSONObject("data/" + name + ".json");
    height = data.getInt("height");
    width  = data.getInt("width");
    JSONArray layers = data.getJSONArray("layers");
    JSONObject tmp = layers.getJSONObject(0);
    themap = tmp.getJSONArray("data");
    tmp = layers.getJSONObject(1);
    objects = tmp.getJSONArray("objects");
  }

  int get(int x, int y) {
    return themap.getInt(x+height*y);
  }


}