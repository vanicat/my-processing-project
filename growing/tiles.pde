PImage[] tiles = new PImage[10*10];

final int rootTiles = 15;
final int seedTiles = 15;
final int waterTiles = 9;
final int trunkTiles = 11;
final int groundTiles = 10;
final int easyDirtTiles = 0;
final int dirtTiles = 4;
final int rockTiles = 5;
final int warpTiles = 6;

class Carte {
  int height;
  int width;
  int energy;
  String name;
  int[] themap;
  JSONArray objects;

  Carte(String theName) {
    JSONObject data;

    name = theName;

    data = loadJSONObject("data/" + name + ".json");
    height = data.getInt("height");
    width  = data.getInt("width");
    JSONArray layers = data.getJSONArray("layers");
    JSONObject tmp;

    tmp = layers.getJSONObject(0);
    themap = tmp.getJSONArray("data").getIntArray();

    tmp = layers.getJSONObject(1);
    objects = tmp.getJSONArray("objects");

    tmp = data.getJSONObject("properties");
    energy = tmp.getInt("energy");
  }

  int get(int x, int y) {
    return themap[(x+width*y)]-1;
  }
}
