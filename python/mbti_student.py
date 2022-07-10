import random as r
import pandas as pd
from settings import *

# ------------------------------------------
# 클래스명 : Student
# 역   할 : mbti찾기, 랜덤대상찾기
# -------------------------------------------
class Student:
    df = pd.read_csv(STUDENTS, index_col=0)
    names = list(df.index)

    def __init__(self, name):
        self.name = name
        self.mbti_type = self.studentMbti()

    # ------------------------------------------------
    # 함수명 : studentMbti
    # 기능 : student 클래스의 이름에 해당하는 mbti 값 찾아줌
    # 파라미터 : 없음
    # 결과값 : str
    # ------------------------------------------------
    def studentMbti(self):
        try:
            df = pd.read_csv('./mbti_student.csv', index_col=0)
            studentMbti = df.loc[self.name,'MBTI']
        except Exception:
            studentMbti = 'none'

        return str(studentMbti)


    # -------------------------------------------------
    # 함수명 : randomStudent
    # 기능 : 랜덤으로 비교할 대상 찾아줌
    # 파라미터 : 없음
    # 결과값 : randomName, randomMbti
    # --------------------------------------------------
    def randomStudent(self, not_include = ''):
        try:
            randomName = r.choice(Student.names)
            while randomName == not_include:
                randomName = r.choice(Student.names)
            randomMbti = str(Student.df.at[randomName,'MBTI'])
        except Exception:
            randomName, randomMbti = 'none', 'none'

        return randomName, randomMbti








