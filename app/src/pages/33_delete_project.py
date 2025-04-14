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
        response = requests.delete(f"http://api:4000/c/projects/{client_id}/{project_id}")
        if response.status_code == 200:
            if response.content:  
                data = response.json()
                st.dataframe(data)
            else:
                st.success("Project deleted successfully.") 
        else:
            st.error(f"Failed to delete project: {response.status_code}")



