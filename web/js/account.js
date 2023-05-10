async function handleEditStatus(event) {
    const type = "accounts"; //Remember to edit this one when apply in another route.
    const url = `${pageContext.servletContext.contextPath}/dashboard/\${type}/update-status`;
    const id = event.target.dataset.id;
    console.log({dataset: event.target.dataset.active})
    const active = !Boolean(event.target.dataset.active == 'active');
    const isConfirm = confirm(`Are you sure to \${active ? "UNBLOCK" : "BLOCK"} \${id}?`);

    if (!isConfirm) return;
    const data = {
        id: id,
        status: active
    }
    const options = {
        method: "POST",
        body: JSON.stringify(data)
    }

    try {
        startLoading();
        const res = await fetch(url, options);
        const result = await res.json();
        if (!res.ok) {
            throw new Error(result.message);
        }
        alert(result.message + "\n We will reload to update new data.");
        window.location.reload();
    } catch (e) {
        console.error(e)
        alert("Cannot update status of " + id);
    }
    stopLoading();
}