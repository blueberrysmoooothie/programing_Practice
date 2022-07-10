def returnHeart(score):
    h="\u2665"
    heart= f'''
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


    sh=heart.split('\n')  # splitheart

    result =''
    if score ==3:
        result = heart.replace('-','*')

    elif score ==2:
        heart.split('\n')
        for i in range(len(sh)):
            if i >= 4:
                sh[i]=sh[i].replace('-','*')
            result = result +(sh[i]+'\n')

    elif score ==1:
        heart.split('\n')
        for i in range(len(sh)):
            if i >= 6:
                sh[i]=sh[i].replace('-','*')
            result = result +(sh[i]+'\n')

    elif score ==0:
        heart.split('\n')
        for i in range(len(sh)):
            if i >= 8:
               sh[i]=sh[i].replace('-','*')
            result = result +(sh[i]+'\n')

    elif score ==-1:
        result = heart.replace(h, '\u2661')

    return result

