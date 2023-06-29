import {useState, useEffect} from "react";
import {ethers} from "ethers";
import test_abi from "../artifacts/contracts/events.sol/Test.json";

export default function HomePage() {
  const [ethWallet, setEthWallet] = useState(undefined);
  const [account, setAccount] = useState(undefined);
  const [evenTes, setevenTes] = useState(undefined);
  const [inputValue, setInputValue] = useState('');
  const [inputValue_II, setInputValue_II] = useState('');
  const [arrayData, setArrayData] = useState([]);
  const [value, setValue] = useState('');
  const [valueRem, setValueRem] = useState('');

  const contractAddress = "0xe2f55536668747dbe0fd0e31ba22da7fdc5aefb2";
  const evenTesABI = test_abi.abi;

  const getWallet = async() => {
    if (window.ethereum) {
      setEthWallet(window.ethereum);
    }

    if (ethWallet) {
      const account = await ethWallet.request({method: "eth_accounts"});
      handleAccount(account);
    }
  }

  const handleAccount = (account) => {
    if (account) {
      console.log ("Account connected: ", account);
      setAccount(account);
    }
    else {
      console.log("No account found");
    }
  }

  const connectAccount = async() => {
    if (!ethWallet) {
      alert('MetaMask wallet is required to connect');
      return;
    }
  
    const accounts = await ethWallet.request({ method: 'eth_requestAccounts' });
    handleAccount(accounts);
    
    // once wallet is set we can get a reference to our deployed contract
    getevenTesContract();
  };

  const getevenTesContract = () => {
    const provider = new ethers.providers.Web3Provider(ethWallet);
    const signer = provider.getSigner();
    const evenTesContract = new ethers.Contract(contractAddress, evenTesABI, signer);
 
    setevenTes(evenTesContract);
  }

  //starting the functions

  const handleInputChange = (event) => {
    setInputValue(event.target.value);
  }

  const handleInputChange_II = (event) => {
    setInputValue_II(event.target.value);
  }

  const handleSubmit = async (event) => {
    if (evenTes){
    event.preventDefault();
    // Call the contract function with the input value
    await evenTes.addMember(inputValue);
    // Do something after the contract function call
    setValue(inputValue, 'was added');
    }
  }

  const remMem = async(event) => {
    if (evenTes) {
      event.preventDefault();
      let tx = await evenTes.removeMember(inputValue_II);
      await tx.wait()
      setValueRem(inputValue_II, 'was removed');
    }
  }

  const getList = async() => {

    if (!evenTes) {
      // Wait for evenTes to be initialized
      await getevenTesContract();
    }

    if (evenTes) {
    const array = await evenTes.getMembers();
    setArrayData(array);
  }
};

//contract functions end here

  const initUser = () => {
    // Check to see if user has Metamask
    if (!ethWallet) {
      return <p>Please install Metamask in order to use this evenTes.</p>
    }

    // Check to see if user is connected. If not, connect to their account
    if (!account) {
      return <button onClick={connectAccount}>Please connect your Metamask wallet</button>
    }


    return (
      <div>
        <p>Your Account: {account}</p>
        <div>
            <form onSubmit={handleSubmit}>
            <input type="text" value={inputValue} onChange={handleInputChange} />
            <button type="submit">Add Member</button>
            <p> {value}</p>
            </form>
        </div>
        <div>
            <form onSubmit={remMem}>
            <input type="text" value={inputValue_II} onChange={handleInputChange_II} />
            <button type="submit">Remove Member</button>
            <p> {valueRem}</p>
            </form>
        </div>
        <div>
            <button onClick={getList}>List of your Members</button>
            {arrayData.map((item, index) => (
            <div key={index}>{item}</div>
    ))}
  </div>
      </div>
    )
  }
  useEffect(() => {getWallet();}, []);

  return (
    <main className="container">
      <header><h1>Welcome to Add members</h1></header>
      {initUser()}
      <style jsx>{`
        .container {
          text-align: center
        }
      `}
      </style>
    </main>
  )
}
