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
  elif re.search(r"KEN", field.name):
    statistic_list.append([field.name, "FIRST"])
  elif re.search(r"MALE_", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"FEMALE_", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"POP_", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"GENHH", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"STNUM", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"WK_", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"IND_", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"TOT", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"X_CODE", field.name):
    statistic_list.append([field.name, "MEAN"])
  elif re.search(r"Y_CODE", field.name):
    statistic_list.append([field.name, "MEAN"])
  elif re.search(r"COORDINATE_AREA", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"Num_Votes", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"Num_Voter", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"Num_Electorate", field.name):
    statistic_list.append([field.name, "SUM"])
  elif re.search(r"Num_Votes_Sum", field.name):
    statistic_list.append([field.name, "SUM"])

arcpy.Dissolve_management(in_features, out_feature_class, dissolve_field, statistic_list, "MULTI_PART", "DISSOLVE_LINES")
