import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

events = requests.get('http://api:4000/m/events').json()
try:
  st.dataframe(events)
except:
  st.write("Could not connect to database to access events")
