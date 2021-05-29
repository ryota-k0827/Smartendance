#!/usr/bin/python3
# -*- coding: utf-8 -*-

# 出席入力プログラム
# 処理内容
# ・student_attendance.htmlから出席データ取得
# ・ビーコン接続
# ・ビーコンデータ取得
# ・DB接続
# ・ビーコンの情報と出席データをDBに保存
# ・DB接続解除
# ・student_attendance_result.htmlに推移
import cgi
import sys
import io
import codecs

# 文字化けエラー対策
#sys.stdout = io.TextIOWrapper(sys.stdoutstdout.buffer, encoding='utf-8')

form = cgi.FieldStorage()

# student_attendance.htmlをロード
if form.list == []:
    html = codecs.open('./html/student_attendance.html', 'r', 'utf-8').read()

# 入力チェック。空白時、エラーページに推移。
else:
    print("エラー：教室番号が空白。")
    html = codecs.open('./html/student_attendance_error.html', 'r', 'utf-8').read()

print("")
print(html)
