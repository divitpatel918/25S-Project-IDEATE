import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Review a Proposal")




advisor_id = st.text_input("Enter Advisor ID to access the file:")

if st.button("View a Proposal"):
    if advisor_id:
        res = requests.get(f"http://api:4000/a/proposal/{advisor_id}")
        if res.status_code == 200:
            response = res.json()
            st.dataframe(response)
        else:
            st.write("Could not connect to the API, or proposal not found.")
    else:
        st.warning("Please enter an Advisor ID.")
