from settings import *
from mbtiTest import mbtiTest
from mbti_student import Student
import pandas as pd
import tkinter as tk


# --------------------------
# 두 유형간의 궁합 정도를 반환
# 입력값 : mbti_type, mbti_type2
# 반환값 : 궁합 정도 설명문, 궁합 점수
# --------------------------
def getMateScore(mbti1, mbti2):
    # pandas 이용
    try:
        score = mate_data[mbti1][mbti2]
        return MATE[score], score

    except:
        return '입력값 오류!', -1


# --------------------------
# menu1 버튼이 눌릴 경우 mbti 검사 화면 보이기
# 입력값 : tkinter.Tk() (화면)
# 반환값 : Nan
# --------------------------
def manu1_pushed(root):
    global frame
    frame.destroy()

    test = mbtiTest() # 검사 객체 선언
    frame = tk.Frame(root, bg=FRAME_COLOR)
    frame.place(x=MENU_WIDTH, y=0, width=WIDTH - MENU_WIDTH, height=HEIGHT)

    question_label = tk.Label(frame, text='', bg=FRAME_COLOR) # 질문 칸
    detail_text = tk.Text(frame) # 상세 결과 출력 칸

    button_frame = tk.Frame(frame, bg=FRAME_COLOR)
    button_frame.place(x=0, y=140, width=WIDTH - MENU_WIDTH + BUTTON_WIDTH, height=BUTTON_HEIGHT)

    # 검사 진행 버튼
    test_button = tk.Button(button_frame, text='test start',
                            command=lambda: test_button_pushed(test, question_label, detail_text), repeatdelay=1000)
    l_button = tk.Button(button_frame, text='Left',
                         command=lambda: L_button_pushed(test, question_label, detail_text), repeatdelay=1000)
    r_button = tk.Button(button_frame, text='Right',
                         command=lambda: R_button_pushed(test, question_label, detail_text), repeatdelay=1000)
    go_disc_button = tk.Button(button_frame, text='상세 설명으로',
                               command=lambda: manu2_pushed(root, mbti_type=test.mbti_type), repeatdelay=1000)

    question_label.place(x=20, y=40, height=100, width=600)
    test_button.place(x=20, y=0, height=BUTTON_HEIGHT, width=BUTTON_WIDTH)
    l_button.place(x=20+BUTTON_WIDTH, y=0, height=BUTTON_HEIGHT, width=BUTTON_WIDTH)
    r_button.place(x=20+BUTTON_WIDTH*2, y=0, height=BUTTON_HEIGHT, width=BUTTON_WIDTH)
    go_disc_button.place(x=20 + BUTTON_WIDTH * 3, y=0, height=BUTTON_HEIGHT, width=BUTTON_WIDTH)
    detail_text.place(x=20, y=200, height=300, width=600)

# --------------------------
# menu2 버튼이 눌릴 경우 mbti 상세 설명 화면 보이기
# 입력값 : tkinter.Tk() (화면)
# 반환값 : Nan
# --------------------------
def manu2_pushed(root, mbti_type='ISFJ'):
    global frame
    global mbti
    frame.destroy()
    if len(mbti_type) < 4:
        mbti_type = 'ISFJ'

    frame = tk.Frame(root, bg=FRAME_COLOR)
    frame.place(x=MENU_WIDTH, y=0, width=WIDTH - MENU_WIDTH, height=HEIGHT)
    detail_text = tk.Text(frame)
    detail_text.place(x=20, y=200, height=300, width=600)

    mbti_index = tk.IntVar()
    rad = []
    radio_frame = tk.Frame(frame, bg=FRAME_COLOR)
    radio_frame.place(x=100, y=100)
    for i in range(len(mbti)):
        rad.append(tk.Radiobutton(radio_frame, text=mbti[i], variable=mbti_index, value=i,
                                  command=lambda: radio_choice(detail_text, mbti_index), bg=FRAME_COLOR))

        rad[i].grid(row=i // 8, column=i % 8, sticky="w")

    rad[mbti.index(mbti_type)].select()
    radio_choice(detail_text, mbti_index, mbti_type)

# --------------------------
# menu3 버튼이 눌릴 경우 mbti 궁합 파악 화면 보이기
# 입력값 : tkinter.Tk() (화면)
# 반환값 : Nan
# --------------------------
def manu3_pushed(root):
    global frame
    frame.destroy()

    frame = tk.Frame(root, bg=FRAME_COLOR)
    frame.place(x=MENU_WIDTH, y=0, width=WIDTH - MENU_WIDTH, height=HEIGHT)

    mate_text1 = tk.Text(frame)
    mate_text2 = tk.Text(frame)
    mate_text1.place(x=65, y=70, height=20, width=60)
    mate_text2.place(x=65, y=160, height=20, width=60)

    mate_button = tk.Button(frame, text='MBTI 궁합 계산', bg='#d4a3e1', repeatdelay=1000,
                            command=lambda: mate_pushed(heart_text, result_label, mate_text1, mate_text2))
    mate_button.place(x=450, y=220, height=BUTTON_HEIGHT, width=BUTTON_WIDTH)

    heart_text = tk.Text(frame, bg=FRAME_COLOR, height=10, width=30)
    heart_text.place(x=100, y=300)

    result_label = tk.Label(frame, bg=FRAME_COLOR)
    result_label.place(x=170, y=450)

    radio_frame = tk.Frame(frame, bg=FRAME_COLOR)
    radio_frame.place(x=180, y=40)

    tk.Label(radio_frame, text='MBTI 1', bg=FRAME_COLOR).grid(row=0, column=0)

    mbti1_index = tk.IntVar()
    rad1 = []
    for i in range(len(mbti)):
        rad1.append(tk.Radiobutton(radio_frame, text=mbti[i], variable=mbti1_index, value=i,
                                   command=lambda: mate_choice(mate_text1, mbti1_index), bg=FRAME_COLOR))

        rad1[i].grid(row=i // 8 + 1, column=i % 8, sticky="w")

    tk.Label(radio_frame, text='', bg=FRAME_COLOR).grid(row=3, column=0)
    tk.Label(radio_frame, text='MBTI 2', bg=FRAME_COLOR).grid(row=4, column=0)
    mbti2_index = tk.IntVar()
    rad2 = []
    for i in range(len(mbti)):
        rad2.append(tk.Radiobutton(radio_frame, text=mbti[i], variable=mbti2_index, value=i,
                                   command=lambda: mate_choice(mate_text2, mbti2_index), bg=FRAME_COLOR))

        rad2[i].grid(row=i // 8 + 5, column=i % 8, sticky="w")

# --------------------------
# menu4 버튼이 눌릴 경우 수강생 mbti 궁합 화면 보이기
# 입력값 : tkinter.Tk() (화면)
# 반환값 : Nan
# --------------------------
def manu4_pushed(root):
    global frame
    frame.destroy()

    frame = tk.Frame(root, bg=FRAME_COLOR)
    frame.place(x=MENU_WIDTH, y=0, width=WIDTH - MENU_WIDTH, height=HEIGHT)

    name_text1 = tk.Text(frame)
    mbti_text1 = tk.Text(frame)

    name_text2 = tk.Text(frame)
    mbti_text2 = tk.Text(frame)

    mbti_text1.config(state='disabled')
    mbti_text2.config(state='disabled')

    layout = [200, 80]
    tk.Label(frame, text='이름 : ', bg=FRAME_COLOR).place(x=layout[0] - 60, y=layout[1])
    name_text1.place(x=layout[0], y=layout[1], height=20, width=60)
    mbti_text1.place(x=layout[0], y=layout[1] + 40, height=20, width=60)
    tk.Label(frame, text='이름 : ', bg=FRAME_COLOR).place(x=layout[0] + 180, y=layout[1])
    name_text2.place(x=layout[0] + 220, y=layout[1], height=20, width=60)
    mbti_text2.place(x=layout[0] + 220, y=layout[1] + 40, height=20, width=60)

    st_mate_button = tk.Button(frame, text='MBTI 궁합 계산', bg=BUTTON_COLOR, repeatdelay=1000,
                               command=lambda: student_mate_pushed(heart_text, result_label,
                                                                   name_text1, name_text2, mbti_text1, mbti_text2))
    st_mate_button.place(x=450, y=220, height=BUTTON_HEIGHT, width=BUTTON_WIDTH)

    st_reset_button = tk.Button(frame, text='초기화', bg=BUTTON_COLOR, repeatdelay=1000,
                                command=lambda: manu4_pushed(root))
    st_reset_button.place(x=450, y=220 + BUTTON_HEIGHT, height=BUTTON_HEIGHT, width=BUTTON_WIDTH)

    heart_text = tk.Text(frame, bg=FRAME_COLOR, height=10, width=30)
    heart_text.place(x=100, y=300)
    result_label = tk.Label(frame, bg=FRAME_COLOR)
    result_label.place(x=170, y=450)


# --------------------------
# test_start 버튼이 눌릴 경우 mbti 검사 시작 및 질문 출력
# 입력값 : mbtiTest 객체, question_label (질문 칸) , detail_text (검사 결과 화면)
# 반환값 : Nan
# --------------------------
def test_button_pushed(test, question_label, detail_text):
    if not test.testing:
        test.mbti_type = ''
        test.getMBTI_gui(question_label, detail_text)
        test.testing = True

# --------------------------
# Left, Right 버튼이 눌릴 경우 결과 반영 및 다음 질문 출력
# 입력값 : mbtiTest 객체, question_label (질문 칸) , detail_text (검사 결과 화면)
# 반환값 : Nan
# --------------------------
def L_button_pushed(test, question_label, detail_text):
    if test.testing:
        test.answer = 1
        test.getMBTI_gui(question_label, detail_text)


def R_button_pushed(test, question_label, detail_text):
    if test.testing:
        test.answer = 0
        test.getMBTI_gui(question_label, detail_text)


# --------------------------
# 상세 설명에서 라디오 버튼이 눌릴 경우 버튼에 저장된 index에 따른 해당 유형의 설명 출력 함수 호출
# 입력값 : detail_text (상세 설명 화면), mbti_index (라디오 버튼에 포함된 변수), mbti_type (menu1에서 넘어올시 작동)
# 반환값 : Nan
# --------------------------
def radio_choice(detail_text, mbti_index, mbti_type=''):
    print(mbti[mbti_index.get()])
    test0 = mbtiTest()
    test0.show_detail(detail_text, mbti[mbti_index.get()])
    if len(mbti_type):
        test0.show_detail(detail_text, mbti_type)


# --------------------------
# 궁합에서 라디오 버튼이 눌릴 경우 버튼에 저장된 index에 따른 해당 유형 출력
# 입력값 :  mate_text (타입 출력 화면), mbti_index (라디오 버튼에 포함된 변수)
# 반환값 : Nan
# --------------------------
def mate_choice(mate_text, mbti_index):
    print(mbti[mbti_index.get()])
    mate_text.config(state='normal')
    mate_text.delete('1.0', 'end')
    mate_text.insert('current', mbti[mbti_index.get()])


# --------------------------
# 궁합에서 라디오 버튼으로 선택한 유형들의 궁합 결과를 출력
# 입력값 : heart_text (하트 그릴 화면), result_label (궁합 결과 출력 화면),
#           mate_text1 (첫 번째 유형이 입력된 text), mate_text2 (두 번째 유형이 입력된 text)
# 반환값 : Nan
# --------------------------
def mate_pushed(heart_text, result_label, mate_text1, mate_text2):
    mbti_type1 = mate_text1.get("1.0", "end").strip()
    mbti_type2 = mate_text2.get("1.0", "end").strip()

    result_label['text'], score = getMateScore(mbti_type1, mbti_type2)

    heart = returnHeart(score)
    if score == 3:
        heart_text['fg'] = 'red'
    else:
        heart_text['fg'] = 'black'

    heart_text.config(state='normal')
    heart_text.delete('1.0', 'end')
    heart_text.insert('current', heart)
    heart_text.config(state='disabled')
    print(score)


# --------------------------
# 수강생 메뉴에서 입력한 수강생들의 유형과 궁합 결과를 출력, 미입력시 랜덤으로 출력
# 입력값 : heart_text (하트 그릴 화면), result_label (궁합 결과 출력 화면),
#           name_text1 (첫 번째 수강생), name_text2 (두 번째 수강생)
#           mate_text1 (첫 번째 유형이 입력될 text), mate_text2 (두 번째 유형이 입력될 text)
# 반환값 : Nan
# --------------------------
def student_mate_pushed(heart_text, result_label, name_text1, name_text2, mate_text1, mate_text2):
    name1 = name_text1.get("1.0", "end").strip()
    name2 = name_text2.get("1.0", "end").strip()

    st0 = Student('0')
    if not len(name1):
        if len(name2):
            name1, mbti_type1 = st0.randomStudent(not_include=name2)
        else:
            name1, mbti_type1 = st0.randomStudent()
        name_text1.insert('current', name1)

    else:
        st1 = Student(name1)
        mbti_type1 = st1.mbti_type

    mate_text1.config(state='normal')
    mate_text1.delete('1.0', 'end')
    mate_text1.insert('current', mbti_type1)
    mate_text1.config(state='disabled')

    if not len(name2):
        name2, mbti_type2 = st0.randomStudent(not_include=name1)
        name_text2.insert('current', name2)

    else:
        st2 = Student(name2)
        mbti_type2 = st2.mbti_type

    mate_text2.config(state='normal')
    mate_text2.delete('1.0', 'end')
    mate_text2.insert('current', mbti_type2)
    mate_text2.config(state='disabled')

    # 만들어둔 결과 출력 함수 사용
    mate_pushed(heart_text, result_label, mate_text1, mate_text2)


def returnHeart(score):
    h = "\u2665"
    heart = f'''
       {h*3}    {h*3}
     {h}------{h}{h}------{h}
    {h}{'-'*18}{h}
     {h}{'-'*16}{h}
      {h}{'-'*14}{h}
        {h}{'-'*10}{h}
          {h}{'-'*6}{h}
            {h}{'-'*2}{h}
              {h}
    '''
    sh = heart.split('\n')  # splitheart

    result = ''
    if score == 3:
        result = heart.replace('-', '*')
    elif score == 2:
        heart.split('\n')
        for i in range(len(sh)):
            if i >= 4:
                sh[i] = sh[i].replace('-', '*')
            result = result + (sh[i] + '\n')

    elif score == 1:
        heart.split('\n')
        for i in range(len(sh)):
            if i >= 6:
                sh[i] = sh[i].replace('-', '*')
            result = result + (sh[i] + '\n')

    elif score == 0:
        heart.split('\n')
        for i in range(len(sh)):
            if i >= 8:
                sh[i] = sh[i].replace('-', '*')
            result = result + (sh[i] + '\n')

    elif score == -1:
        result = heart.replace(h, '\u2661')

    return result


if __name__ == '__main__':
    # -------------------------
    # settings 파일의 MBTI_MATE 자료에서 mbti 유형간의 궁합 점수를 pandas dataFrame으로 변환하고
    # mbti 변수를 인덱스로 활용하여 쉽게 접근할 수 있도록 처리
    # -------------------------
    mate_data = pd.read_csv(MBTI_MATE, index_col=0)
    mbti = list(mate_data.index)

    root = tk.Tk()
    root.title('MBTI')
    root.geometry(f'{WIDTH}x{HEIGHT}+100+100')
    root.resizable(False, False)
    frame = tk.Frame(root, bg=FRAME_COLOR)

    # gui 그리기
    # 메뉴
    canvas = tk.Canvas(
        root,
        height=HEIGHT,
        width=MENU_WIDTH,
        bg="#fff"
    )

    canvas.place(x=0, y=0, height=HEIGHT, width=MENU_WIDTH)
    canvas.create_rectangle(0, 0, MENU_WIDTH, HEIGHT,
                            outline=MENU_COLOR, fill=MENU_COLOR)

    menu_frame = tk.LabelFrame(root, text='menu', bg=MENU_COLOR)
    menu_frame.place(x=20, y=20, height=HEIGHT - 40, width=MENU_WIDTH - 40)
    menu1 = tk.Button(menu_frame, text='MBTI TEST', bg=MENU_COLOR, repeatdelay=1000,
                      command=lambda: manu1_pushed(root))
    menu2 = tk.Button(menu_frame, text='MBTI 상세 설명', bg=MENU_COLOR, repeatdelay=1000,
                      command=lambda: manu2_pushed(root))
    menu3 = tk.Button(menu_frame, text='MBTI 궁합', bg=MENU_COLOR, repeatdelay=1000,
                      command=lambda: manu3_pushed(root))
    menu4 = tk.Button(menu_frame, text='수강생 MBTI 궁합', bg=MENU_COLOR, repeatdelay=1000,
                      command=lambda: manu4_pushed(root))
    menu1.pack(fill='both', pady=2)
    menu2.pack(fill='both', pady=2)
    menu3.pack(fill='both', pady=2)
    menu4.pack(fill='both', pady=2)

    IMG = tk.PhotoImage(file=RELATION_IMG_PATH + '3.png')
    label = tk.Label(root, image=IMG)
    label.place(x=MENU_WIDTH + 100, y=100)

    root.mainloop()
