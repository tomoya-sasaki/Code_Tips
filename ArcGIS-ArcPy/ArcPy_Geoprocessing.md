# ArcPy / Geoprocessing

### Geoprocessing for the data with specific variable
| City | DistrictID |
|:----:|:----------:|
|   A  |     001    |
|   B  |     001    |
|   C  |     002    |
|   D  |     003    |
|   E  |     003    |
のようなデータから、`DistrictID`に従ってGeoprocessingを行う<br>

```Python
arcpy.env.workspace = r"C:/Users/admin/Desctop/14_kanagawa/14_kanagawa.gdb"

in_features = "町丁字別_人口密度"
out_feature_class = "Election_District"

dissolve_field = "kanagawa$.District_code"

arcpy.Dissolve_management(in_features, out_feature_class, dissolve_field, "", "MULTI_PART", "DISSOLVE_LINES")
```
