from settings import *


def get_questions():
    with open(QUESTIONS, 'r', encoding='utf-8') as f:
        total = f.read()
    head_question = []
    MBTI_answers = []
    for data in total.split('<title>')[1:]:

        datas = [x for x in data.strip().split('\n') if len(x)][2:]

        for i in range(len(datas)):
            if not i % 2:
                head_question.append(datas[i])
            else:
                MBTI_answers.append(datas[i])

    return head_question, MBTI_answers


class mbtiTest:
    head_question, MBTI_answers = get_questions()

    def __init__(self):
        self.mbti_type = ''
        self.testing = False
        self.answer = 0
        self.question_num = -1
        self.result = 0


    # 함수 설명 --------------------------------------
    #   함수명 : mbtiTest.mbtiDetail
    #   입력값 : mbti_type
    #   반환값 : mbti 유형 설명 문자열 리스트
    #   기능   : 해당 유형의 자세한 특징 불러오기
    # ------------------------------------------------
    def mbtiDetail(self, mbti_type):
        path = './mbti_info/'+mbti_type+'.txt'
        with open(path, mode='r', encoding='utf-8') as f:
            data = []
            for d in f.readlines():
                data.append(d.replace('. ', '. \n'))
        return data


    # 함수 설명 --------------------------------------
    #   함수명 : mbtiTest.show_detail
    #   입력값 : detail_text (설명 입력칸), mbti_type
    #   반환값 : Nan
    #   기능   : 해당 유형의 자세한 특징 입력 칸에 출력
    # ------------------------------------------------
    def show_detail(self, detail_text, mbti_type):
        detail = self.mbtiDetail(mbti_type)

        detail_text.config(state='normal')
        detail_text.delete('1.0', 'end')
        for i in range(len(detail)):
            if len(detail[i].strip()):
                detail_text.insert('current', detail[i] + '\n\n')
        detail_text.config(state='disabled')


    # 함수 설명 --------------------------------------
    #   함수명 : getMBTI_gui.getMBTI
    #   입력값 : none
    #   반환값 : mbti_type
    #   기능   : tkinter 사용해 설문에 응답 입력 받고 mbti 유형 추정
    # ------------------------------------------------
    def getMBTI_gui(self, question_label, detail_text):
        self.question_num = self.question_num+1
        if self.question_num == 12 : # 모든 질문 문답 시
            self.testing = False    # 검사 종료
            question_label['text'] = '당신의 MBTI 성향은 ' + self.mbti_type + '!' # 검사 결과 출력
            self.show_detail(detail_text, self.mbti_type) # 상세 결과 출력

            self.question_num = -1  # 다음 검사를 위해 초기화

        else:
            kind = MBTI_KIND[self.question_num // 3] # 분류 유형 변환

            self.result = self.result + self.answer
            if self.question_num % 3 == 2:
                if self.result > 1:
                    self.choice = 0 # 유형 '문자열' 의 첫 번째 값
                else:
                    self.choice = -1 # 유형 '문자열' 의 마지막 값
                self.mbti_type = self.mbti_type+ kind[self.choice] # 뽑아낸 문자를 최종 결과에 추가

                self.result = 0 # 분류 유형 변환시 초기화

            # head 문제와 대답 후보
            question = mbtiTest.head_question[self.question_num]
            answers = mbtiTest.MBTI_answers[self.question_num].split('vs')
            question_label['text'] = question + '\n\n'+ answers[0] + '\t\t\nVS \n\t\t\t' + answers[1]
