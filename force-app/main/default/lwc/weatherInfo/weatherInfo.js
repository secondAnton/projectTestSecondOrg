import { LightningElement, api} from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import ICONS_URL from '@salesforce/resourceUrl/LDSIconsSVGs';
import WEATHER_ICONS from '@salesforce/resourceUrl/WeatherIcons';
import SVG_LOGO from "@salesforce/resourceUrl/logo";
import getWeatherInfo from '@salesforce/apex/WeatherInfoController.getWeatherInfo';
import getUserCity from '@salesforce/apex/WeatherInfoController.getUserCity';
import getAccount from '@salesforce/apex/WeatherInfoController.getAccount';

export default class WeatherInfo extends LightningElement {
    @api recordId;
    userCity;
    accountData;
    weatherCondition = {
        condition : '',
        temperature: '',
        pressure: '',
        humidity: '',
        windSpeed: '',
        windDirection: ''
    };
    ICON_DOWNLOAD = ICONS_URL + '/file_download.svg#Actions/file_download';
    ICON_UPLOAD = ICONS_URL + '/file_upload.svg#Actions/file_upload';
    ICON_WEATHER = WEATHER_ICONS + '/day.svg#day';
    //ICON_DAY =  DAY_URL + '/day.svg#day';;
    svgURL = `${SVG_LOGO}#logo`;

    testVar;
    hasRendered = true;


    connectedCallback() {
        this.loadAccount();
        this.loadUserCity();
		this.loadWeather();
        this.testVar = 12345;
	}

    renderedCallback() {
        //guarding code inside the renderedCallback using boolean property
        if (this.hasRendered) {
            //this.loadUserCity();
		    //this.loadWeather();
            this.hasRendered = false;
        }
    }

    loadAccount() {
        getAccount({recordId: this.recordId})
        .then(result => {
            this.accountData = result;
            console.log('Account data ',this.accountData);
        })
        .catch(error => {
			const event = new ShowToastEvent({
				title: 'Error',
				message: error.body.message,
				variant: 'error'
			});
			this.dispatchEvent(event);
		})
    }

    loadWeather() {
        getWeatherInfo({cityName: this.userCity})
		.then(result => {
			this.weatherCondition = result;
            console.log('weatherCondition ',this.weatherCondition);
            console.log('condition',this.weatherCondition.condition);
		})
		.catch(error => {
			const event = new ShowToastEvent({
				title: 'Error',
				message: error.body.message,
				variant: 'error'
			});
			this.dispatchEvent(event);
		})
    }

    loadUserCity() {
        getUserCity({recordId: this.recordId})
		.then(result => {
			this.userCity = result;
            console.log('userCity ',this.userCity);
            this.loadWeather();
		})
		.catch(error => {
			const event = new ShowToastEvent({
				title: 'Error',
				message: error.body.message,
				variant: 'error'
			});
			this.dispatchEvent(event);
		})
    }

    get weatherColor() {
        //if changeStle is true, getter will return class1 else class2
          return this.weatherCondition.temperature < 0 ? 'coldWeather'
                : this.weatherCondition.temperature > 0 && this.weatherCondition.temperature < 25 ? 'normalWeather'
                :'hotWeater';
    }
}