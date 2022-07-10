import pandas as pd
from settings import *

class class01 :

  def getMateScore(self, mbti1, mbti2):
    try:
      mateChart = pd.read_csv('./mbti_mate.csv', index_col=0)
      score = mateChart.at[mbti1, mbti2]
      result = MATE[score]
    except:
      result = 'none'
    print(result)
    return result

cl = class01()
cl.getMateScore("INFJ","AAAA")

