import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Get Member Information Working on Project")




project_id = st.text_input("Enter Project ID to view Members:")

if st.button("Get Member Informations"):
    if project_id:
        response = requests.get(f"http://api:4000/c/memberproject/{project_id}")
        if response.status_code == 200:
            response = response.json()
            st.dataframe(response)
        else:
            st.write("Could not connect to the API, or project not found.")
    else:
        st.warning("Please enter a Project ID.")



