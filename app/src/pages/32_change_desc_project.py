import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Update Project Description")



project_id = st.text_input("Enter Project ID to change project description:")
new_description = st.text_input("Enter New Project Description:")

if st.button("Change Project Descprition"):
    if project_id and new_description:

        data = {
            "project_description": new_description
        }
        response = requests.put(f"http://api:4000/c/projects/{project_id}", json=data)
        if response.status_code == 200:
            st.dataframe(response)
        else:
            st.write("Could not connect to the API, or project not found.")
    else:
        st.warning("Please enter a Project ID.")






