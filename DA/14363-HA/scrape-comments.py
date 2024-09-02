from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
#import bs4
from bs4 import BeautifulSoup
# selenium 4
from selenium import webdriver
# from selenium.webdriver.chrome.service import Service as ChromeService
# from webdriver_manager.chrome import ChromeDriverManager
# #driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))
# # selenium 3
# from selenium import webdriver
# from webdriver_manager.firefox import GeckoDriverManager
# 
# driver = webdriver.Firefox(executable_path=GeckoDriverManager().install())

# selenium 4
from selenium import webdriver
from selenium.webdriver.firefox.service import Service as FirefoxService
from webdriver_manager.firefox import GeckoDriverManager

driver = webdriver.Firefox(service=FirefoxService(GeckoDriverManager().install()))
#wks.
# # Set up the Chrome driver
# service = Service(ChromeDriverManager().install())
# driver = webdriver.Chrome(service=service)
# driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))

# Open the webpage
driver.get("https://www.zeit.de")
page = 'https://www.zeit.de/politik/deutschland/2024-09/wahlverhalten-landtagswahlen-sachen-thueringen-alter-beteiligung'
driver.get(page)

# Add any necessary waits for the page to load
driver.implicitly_wait(10)

# Example: Find the comments section
com_button = '//*[@id="js-article"]/header/div[4]/a'
com_button_fire = '/html/body/div[4]/div/main/article/header/div[4]/a'
comments_button = driver.find_element(By.XPATH, com_button_fire)
comments_button.click()

# Wait for comments to load
driver.implicitly_wait(50)

# Get the page source and parse it with BeautifulSoup
soup = BeautifulSoup(driver.page_source, 'html.parser')
# def output_to_file(soup,newfilepath):
#         with open(newfilepath, 'w') as outfile:
#             output = str(soup)
#             outfile.write(output)
#         return(x)
html_string = str(soup)
with open("output.html", "w") as file:
     file.write(html_string)                  
output_to_file(soup,"com-test.html")
# Find all comment elements
comments = soup.find_all('div', class_='comment__body comment__user-input')
file = open("comments.txt","w")
file.write(str(comments))

file = open("comments.txt","a")

# Extract and print the text of each comment
for comment in comments:
    print(comment.get_text())
    file.write(str(comment))

# Close the browser
#driver.quit()
