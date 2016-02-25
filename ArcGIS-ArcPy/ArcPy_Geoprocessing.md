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
import arcpy
import re

arcpy.env.workspace = r"C:/Users/admin/Desctop/14_kanagawa/14_kanagawa.gdb"

in_features = "町丁字別_人口密度"
out_feature_class = "Election_District"

dissolve_field = "kanagawa$.District_code"

# ある程度データを引き継ぐための準備
fields = arcpy.ListFields(in_features)

statistic_list = []
for field in fields:
  if re.search(r"OBJECTID", field.name):
    continue
  if re.search(r"KEN", field.name):
    statistic_list.append([field.name, "FIRST"])
  if re.search(r"MALE", field.name):
    statistic_list.append([field.name, "SUM"])

arcpy.Dissolve_management(in_features, out_feature_class, dissolve_field, statistic_list, "MULTI_PART", "DISSOLVE_LINES")
```
統計処理をする場合は、`statistics_fields=[['Code_Dist','LAST'],['Population','SUM']]`のようになっていなければならない。
