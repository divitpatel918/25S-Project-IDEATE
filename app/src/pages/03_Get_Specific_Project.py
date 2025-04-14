import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Get Specific Project Info")
project_id = st.text_input("Enter Project ID: ")

if st.button("Access Info"):
    if project_id:
        response = requests.get(f"http://api:4000/e/projects/{project_id}")
        if response.status_code == 200:
            data = response.json()
            st.dataframe(data)
        else:
            st.write("Could not connect to the API, or project not found.")
    else:
        st.warning("Please enter a Project ID.")