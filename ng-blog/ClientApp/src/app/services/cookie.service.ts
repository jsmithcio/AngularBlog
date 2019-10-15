import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CookieService {

	private _message: string = "";

	constructor() { }

	//private isConsented: boolean = false;
    	
	public deleteCookie(name) {
		this.setCookie(name, '', -1);
	}

	public getCookie(name: string) {
		const cookieArray: Array<string> = document.cookie.split(';');
		const cookieArrayLen: number = cookieArray.length;
		const cookieName = `${name}=`;
		let cookieTemp: string;      

		for (let i = 0; i < cookieArrayLen; i += 1) {
			cookieTemp = cookieArray[i].replace(/^\s+/g, '');
			if (cookieTemp.indexOf(cookieName) === 0) {
				this._message = cookieTemp.substring(cookieName.length, cookieTemp.length);
				  console.log("getCookie: " + this._message);
				  return this._message;
			}
		}
		return '';
	}

	get(key: string): string {
		const decodedCookie: string = decodeURIComponent(document.cookie);
		const pairs: string[] = decodedCookie.split(/;\s*/);
		const prefix = `${key}=`;
		for (const pair of pairs) {
			if (pair.indexOf(prefix) == 0) {
				return pair.substring(prefix.length);
			}
		}
		return "";
	}
        
	private setCookie(name: string, value: string, expireDays: number, path: string = '') {
		console.log(name + " " + value);
		this._message = "";
		const expiryDate: Date = new Date();
		expiryDate.setTime(expiryDate.getTime() + expireDays * 24 * 60 * 60 * 1000);
		const expirationDate = `expires=${expiryDate.toUTCString()}`;
		const cookiePath = path ? `; path=${path}` : '';
		this._message = `${name}=${value}; ${expirationDate}${cookiePath}`;
		document.cookie = `${name}=${value}; ${expirationDate}${cookiePath}`;
		console.log("setCookie: " + this._message);
	}

	public consent(name: string, value: string, expireDays: number, path: string = '') {
		this.setCookie(name, value, expireDays, path);
	}
        
	

}

