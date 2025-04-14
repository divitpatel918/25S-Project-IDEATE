import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Delete Project ")




project_id = st.text_input("Enter Project ID to Delete Project:")
client_id = st.text_input("Enter Client ID to Delete Project:") 

if st.button("Delete Project"):
    if project_id and client_id:
        response = requests.delete(f"http://api:4000/c/projects/{client_id}/{project_id}").json()
        if response.status_code == 200:
            st.dataframe(response)
        else:
            st.write("Could not connect to the API, or project not found.")
    else:
        st.warning("Please enter a Project ID.")




