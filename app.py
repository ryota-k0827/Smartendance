from flask import Flask, render_template, request

app = Flask(__name__)


# トップページ
@app.route('/')
def index():
    return render_template('index.html')


@app.route('/student_absence.html')
def student_absence():
    return render_template('student_absence.html')


@app.route('/student_absence_error.html')
def student_absence_error():
    return render_template('student_absence_error.html')


@app.route('/student_absence_result.html')
def student_absence_result():
    return render_template('student_absence_result.html')


# 出席確認ページ
@app.route('/student_attendance.html')
def student_attendance():
    return render_template('student_attendance.html')


# 出席席確認ページで出席ボタン押した時の処理
@app.route('/student_attendance_result.html', methods=['POST'])
def student_attendance_result():
    classroom_number = request.form['classroom_number']

    # 空白エラー
    if not classroom_number:
        return render_template('student_attendance_error.html')

    # 正常処理
    else:
        return render_template('student_attendance_result.html', \
                               classroom_number = classroom_number)


@app.route('/student_grade_inquiry.html')
def student_grade_inquiry():
    return render_template('student_grade_inquiry.html')


@app.route('/student_select.html')
def student_select():
    return render_template('student_select.html')


@app.route('/teacher_select.html')
def teacher_select():
    return render_template('teacher_select.html')


# @app.route('/', methods=['POST'])
# def post():
#     name = request.form['name']
#     if not name:
#         return render_template('error.htmls')
#     return render_template('result.html', \
#             name = name)


if __name__ == '__main__':
    app.run(debug=True)
