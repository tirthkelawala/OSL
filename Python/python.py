# coding: utf-8

# In[1]:

import urllib


# In[7]:


# In[8]:

from bs4 import BeautifulSoup
import winsound


# In[9]:

def save(link, SaveAs):
    urllib2.urlretrieve(link, SaveAs)


# In[10]:

def getLink(url, search, attr):
    query = urllib.parse.quote(search)
    response = urllib.urlopen(url + query)
    soup = BeautifulSoup(response.read(),"lxml")
    for vid in soup.findAll(attrs={'class':attr})[0:1]:
        return vid['href']


# In[13]:



# In[ ]:

song = input()
print('>>> Downloading Song : \t'+song)
try:
    download(song)
    print('>>> '+(str(i+1))+' down '+str(n-i-1)+' to go\t\t'+song+' is Done\n')
except:
    print('Exception : I guess you need to check the internet connection')
print('song downloaded')
winsound.Beep(2000,4000)


# In[ ]:

