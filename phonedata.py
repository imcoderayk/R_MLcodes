# Implementing Apriori algorithm from mlxtend

# conda install mlxtend
# or
# pip install mlxtend

import pandas as pd
from mlxtend.frequent_patterns import apriori, association_rules

phonedata = pd.read_csv('E://360DigiTMG//myphonedata.csv')


# barplot of top 10 
import matplotlib.pyplot as plt

phonedata_bin = phonedata.iloc[:,3:9]

frequent_itemsets = apriori(phonedata_bin, min_support = 0.006, max_len = 4, use_colnames = True)

# Most Frequent item sets based on support 
frequent_itemsets.sort_values('support', ascending = False, inplace = True)

plt.bar(x = list(range(0, 12)), height = frequent_itemsets.support[0:12], color ='rgmyk')
plt.xticks(list(range(0, 12)), frequent_itemsets.itemsets[0:12], rotation=20)
plt.xlabel('item-sets')
plt.ylabel('support')
plt.show()

rules = association_rules(frequent_itemsets, metric = "lift", min_threshold = 1)
rules.head(20)
rules.sort_values('lift', ascending = False).head(10)

