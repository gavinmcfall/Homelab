function getAucklandDateTime() {
  const options = {
    timeZone: "Pacific/Auckland",
    year: "numeric",
    month: "short",
    day: "2-digit",
    hour: "numeric",
    minute: "2-digit",
    hour12: true,
  };

  const formatter = new Intl.DateTimeFormat("en-US", options);
  return formatter.formatToParts(new Date());
}

function getAucklandGreeting() {
  const dateTimeParts = getAucklandDateTime();

  const hour = parseInt(
    dateTimeParts.find((part) => part.type === "hour").value,
    10
  );
  const minute = parseInt(
    dateTimeParts.find((part) => part.type === "minute").value,
    10
  );
  const isAM =
    dateTimeParts.find((part) => part.type === "dayPeriod").value === "AM";

  // Adjust hour to 24-hour format for easier comparison
  const hour24 = isAM ? hour : hour === 12 ? 12 : hour + 12;

  if (hour24 >= 5 && hour24 < 12) {
    return "Good Morning";
  } else if (hour24 >= 12 && hour24 < 18) {
    return "Good Afternoon";
  } else {
    return "Good Evening";
  }
}

function getFormattedAucklandDateTime() {
  const dateTimeParts = getAucklandDateTime();

  const year = dateTimeParts.find((part) => part.type === "year").value;
  const month = dateTimeParts.find((part) => part.type === "month").value;
  const day = dateTimeParts.find((part) => part.type === "day").value;
  const hour = dateTimeParts.find((part) => part.type === "hour").value;
  const minute = dateTimeParts.find((part) => part.type === "minute").value;
  const dayPeriod = dateTimeParts.find(
    (part) => part.type === "dayPeriod"
  ).value;

  return `${year}-${month}-${day} ${hour}:${minute} ${dayPeriod}`;
}

// Display the greeting
document.getElementById("greeting").innerText = getAucklandGreeting();

// Display the formatted date and time
document.getElementById("datetime").innerText = getFormattedAucklandDateTime();
