import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Get April 1 Project/Client Info")

response = requests.get(f"http://api:4000/e/clients")

if response.status_code == 200:
    response = response.json()
    st.dataframe(response)
else:
     st.write("Could not connect to the API, or project not found.")