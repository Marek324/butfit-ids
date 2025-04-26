https://github.com/faker-js/faker/tree/next

https://stackblitz.com/edit/faker-js-demo?file=index.ts

### Client
```ts
import { fakerEN as faker } from '@faker-js/faker';

const appDiv: HTMLElement = document.querySelector('#app')!;
const getGenderString = (short: string): 'male' | 'female' =>
  short === 'M' ? 'male' : 'female';
let data = '';
for (let i = 1; i <= 20; i++) {
  const gender = Math.random() < 0.5 ? 'M' : 'F';
  const fName = faker.person.firstName(getGenderString(gender));
  const lName = faker.person.lastName(getGenderString(gender));

  const birth = faker.date.birthdate();
  const year = birth.getFullYear();
  const month = String(birth.getMonth() + 1).padStart(2, '0');
  const day = String(birth.getDate()).padStart(2, '0');
  const birthDate = `${year}-${month}-${day}`;

  const telNum = faker.phone.number({ style: 'international' });
  const mail = faker.internet.email({firstName: fName, lastName: lName});

  const genderSet = Math.random() >= 0.5 ? true : false;
  const dateSet = Math.random() >= 0.5 ? true : false;

  data += `INSERT INTO Client (FirstName, LastName`;
  if (genderSet) data += `, Gender`;
  if (dateSet) data += `, BirthDate`;

  data += `, TelNumber, Email) VALUES<br>('${fName}', '${lName}'`;

  if (genderSet) data += `, '${gender}'`;
  if (dateSet) data += `, TO_DATE('${birthDate}', 'YYYY-MM-DD')`;

  data += `, '${telNum}', '${mail}');<br>`;
}
appDiv.innerHTML += `<p>${data}</p>`;
```

### Employee
```ts
import { fakerEN as faker } from '@faker-js/faker';

const appDiv: HTMLElement = document.querySelector('#app')!;
let data = '';
for (let i = 1; i <= 20; i++) {
  const telNum = faker.phone.number({ style: 'international' });
  const mail = faker.internet.email();

  data += `INSERT INTO Employee (TelNumber, Email) VALUES<br>
  ('${telNum}', '${mail}');<br>`;
}
appDiv.innerHTML += `<p>${data}</p>`;
```

### Account
```ts
import { fakerEN as faker } from '@faker-js/faker';

const appDiv: HTMLElement = document.querySelector('#app')!;
let data = '';
for (let i = 1; i <= 50; i++) {
  const date = faker.date.between({
    from: new Date('2021-04-12'),
    to: new Date('2023-04-12'),
  });
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  const creationDate = `${year}-${month}-${day}`;

  const amount = Math.floor(Math.random() * 20000 * 100) / 100 + 1;
  const currency = faker.finance.currencyCode();
  const ownerID = Math.floor(Math.random() * 20) + 1;
  const employeeID = Math.floor(Math.random() * 20) + 1;

  data += `INSERT INTO Account (CreationDate, Balance, CurrencyCode, OwnerID, EmployeeID) VALUES<br>
  (TO_DATE('${creationDate}', 'YYYY-MM-DD'), ${amount}, '${currency}', ${ownerID}, ${employeeID});<br>`;
}
appDiv.innerHTML += `<p>${data}</p>`;
```

### AuthorizedAccess
```ts
import { fakerEN as faker } from '@faker-js/faker';

const appDiv: HTMLElement = document.querySelector('#app')!;
let data = '';
for (let i = 1; i <= 50; i++) {
  const amount = Math.floor(Math.random() * 5000 * 100) / 100 + 1;
  const clientID = Math.floor(Math.random() * 20) + 1;
  const accountID = Math.floor(Math.random() * 50) + 1;
  const employeeID = Math.floor(Math.random() * 20) + 1;

  data += `INSERT INTO AuthorizedAccess (ClientID, AccountID, EmployeeID, AuthorizedLimit) VALUES<br>
  (${clientID}, ${accountID}, ${employeeID}, ${amount});<br>`;
}
appDiv.innerHTML += `<p>${data}</p>`;
```

### Transaction
```ts
import { fakerEN as faker } from '@faker-js/faker';

const appDiv: HTMLElement = document.querySelector('#app')!;
let data = '';
for (let i = 1; i <= 250; i++) {
  const accountID = Math.floor(Math.random() * 50) + 1;

  const time = faker.date.between({
    from: new Date('2023-04-12'),
    to: Date.now(),
  });
  const year = time.getFullYear();
  const month = String(time.getMonth() + 1).padStart(2, '0');
  const day = String(time.getDate()).padStart(2, '0');
  const hours = String(time.getHours()).padStart(2, '0');
  const minutes = String(time.getMinutes()).padStart(2, '0');
  const seconds = String(time.getSeconds()).padStart(2, '0');
  const transactionTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

  const amount = Math.floor(Math.random() * 3000 * 100) / 100 + 1;
  const incoming = Math.random() < 0.5 ? 0 : 1;
  const type = Math.random() < 0.5 ? 'Movement' : 'Transfer';
  data += `INSERT INTO Transaction (AccountID, Time, Amount, Incoming, Type`;

  if (type === 'Transfer') data += `, IBAN`;

  data += `) VALUES<br>(${accountID}, TO_TIMESTAMP('${transactionTime}', 'YYYY-MM-DD HH24:MI:SS'), ${amount}, ${incoming}, '${type}'`;

  if (type === 'Transfer') {
    const iban = faker.finance.iban();
    data += `, '${iban}'`;
  }

  data += `);<br>`;
}
appDiv.innerHTML += `<p>${data}</p>`;
```