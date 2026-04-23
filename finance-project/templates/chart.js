async function loadData() {
    // Analytics fetch karo
    const res = await fetch('/api/transactions/analytics/');
    const data = await res.json();
    
    document.getElementById('total-income').innerText = `₹${data.total_income}`;
    document.getElementById('total-expense').innerText = `₹${data.total_expense}`;

    // Chart.js update karo (Pie chart for Analytics)
    const ctx = document.getElementById('myChart').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Income', 'Expense'],
            datasets: [{
                data: [data.total_income, data.total_expense],
                backgroundColor: ['#198754', '#dc3545']
            }]
        }
    });
}
window.onload = loadData;