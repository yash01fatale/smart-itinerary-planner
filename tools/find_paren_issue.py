from pathlib import Path
s=Path('lib/screens/messageScreens/chatScreen.dart').read_text()
stack=[]
for i,ch in enumerate(s):
    if ch=='(':
        stack.append(i)
    elif ch==')':
        if stack:
            stack.pop()
        else:
            print('Extra ) at',i)
            break
if stack:
    print('Unmatched ( at positions (showing last 10):', stack[-10:])
    for pos in stack[-10:]:
        line=s.count('\n',0,pos)+1
        col=pos - s.rfind('\n',0,pos)
        print('pos',pos,'line',line,'col',col, s.splitlines()[line-1])
else:
    print('All parentheses matched')
