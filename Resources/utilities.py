import xlrd
import xlwt
import mysql.connector
from mysql.connector import Error
import requests
# from selenium import webdriver
from robot.libraries.BuiltIn import BuiltIn


def write_to_excel(my_list, WritefilePath):
    wb = xlwt.Workbook()
    ws = wb.add_sheet("Invalid Links")
    for i in range(len(my_list)):
        ws.write(i,0,my_list[i])
    wb.save(WritefilePath)

def read_data_from_excel(filename, sheet):
    workbook1 = xlrd.open_workbook(filename)
    sheet = workbook1.sheet_by_name(sheet)
    row_count = sheet.nrows
    col_count = sheet.ncols
    # print(f'rows : {row_count} cols: {col_count}')
    data=  [ [ 0 for i in range(col_count) ] for j in range(row_count) ]
    i=1
    j=0
    for i in range(1,row_count):
        for j in range(col_count):
            if type(sheet.cell_value(i, j)) == float:
                mob= int(sheet.cell_value(i, j))
                data[i][j]=mob
                # print(mob, end=" ")
            else:
                data[i][j] = sheet.cell_value(i, j)

    return data[1:]


def db_test(phone_no):
    try:
        connection = mysql.connector.connect(host='101.53.139.124',
                                             database='collegedunia_test',
                                             user='test',
                                             password='TesterOnly')
        cursor = connection.cursor()

        '''Note: connector is mysql driver for python.
        The connect() constructor creates a connection to the MySQL server and returns a MySQLConnection object.
    To handle connection errors, use the try statement and catch all errors using the errors.Error exception:
We then create a new cursor, by default a MySQLCursor object, using the connection's cursor() method.
         
        '''

        # if connection.is_connected():
        #     db_Info = connection.get_server_info()
        #     print("Connected to MySQL Server version ", db_Info)
        #     cursor = connection.cursor()
        #     cursor.execute("select database();")
        #     record = cursor.fetchone()
        #     print("You're connected to database: ", record)

        query = """select * from leads where phone_no= %s"""
        cursor.execute(query, (phone_no,))

        record = cursor.fetchall()
        # my_result=[]
        one_record=[]
        # row=''
        for row in record:
            print("lead id = ", row[0], )
            print("Name = ", row[1])
            print("email = ", row[2])
            print("phone no  = ", row[3], "\n")
            print("city  = ", row[26], "\n")
            print("course  = ", row[40], "\n")
        for row in record:
            one_record.append(row[0])
            one_record.append(row[1])
            one_record.append(row[2])
            one_record.append(row[3])
            one_record.append(row[26])
            one_record.append(row[40])
            # my_result.append(one_record)
        print(f"select query executed successfully with lead id : {row[0]}")


    except Error as e:
        print(f"Error while connecting to MySQL: {e}")

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
            print("MySQL connection is closed")

    return one_record



# options = webdriver.ChromeOptions()
# options.add_argument("start-maximized")
# options.add_argument('disable-infobars')
# driver=webdriver.Chrome(chrome_options=options, executable_path=r'C:\Utility\BrowserDrivers\chromedriver.exe')
# driver.get('https://google.co.in/')


# sel_obj = BuiltIn().get_library_instance('SeleniumLibrary')
def find_broken_links(url):
    driver.get(url)
    out=[]
    links = driver.find_elements_by_css_selector("a")
    for link in links:
        r = requests.head(link.get_attribute('href'))
        print(link.get_attribute('href'), r.status_code)
        if r.status_code!=400:
            out.append(link.get_attribute('href'))
    return out
