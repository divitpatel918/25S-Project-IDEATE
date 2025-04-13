import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# View Status Updates for a Project")




project_id = st.text_input("Enter Project ID to view status updates:")

if st.button("Get Status Updates"):
    if project_id:
        res = requests.get(f"http://api:4000/c/statusupdate/{project_id}")
        if res.status_code == 200:
            response = res.json()
            st.dataframe(response)
        else:
            st.write("Could not connect to the API, or project not found.")
    else:
        st.warning("Please enter a Project ID.")
