////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package {
	import flash.display.Sprite;
	
	import flashx.textLayout.compose.StandardFlowComposer;
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.conversion.TextConverter;

	/** Same as the "Hello, World" text example except that text is read in dynamically based on markup string.  */
	public class ImportMarkup extends Sprite
	{
		public function ImportMarkup()
		{
			var markup:String = "<TextFlow xmlns='http://ns.adobe.com/textLayout/2008'><p><span>Hello, World</span></p></TextFlow>";
			var textFlow:TextFlow = TextConverter.importToFlow(markup, TextConverter.TEXT_LAYOUT_FORMAT);
			textFlow.flowComposer.addController(new ContainerController(this, 200, 50));
			textFlow.flowComposer.updateAllControllers();
		}
	}
}
